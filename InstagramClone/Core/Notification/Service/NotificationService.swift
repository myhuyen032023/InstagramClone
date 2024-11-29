//
//  NotificationService.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 11/9/24.
//

import FirebaseAuth
import FirebaseFirestore

class NotificationService {
    func fetchNotifications() async throws -> [Notification] {
        guard let currentUid = Auth.auth().currentUser?.uid else { return []}
        let snapshot = try await FirestoreConstants.userNotificationsCollection(uid: currentUid)
            .order(by: "timestamp", descending: true)
            .getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: Notification.self) })
    }
    
    func uploadNotification(toUid uid: String, type: NotificationType, post: Post? = nil) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid, uid != currentUid else { return }
        let ref = FirestoreConstants.userNotificationsCollection(uid: uid).document()
        
        let notification = Notification(id: ref.documentID,
                                        postId: post?.id,
                                        notificationSenderUid: currentUid, 
                                        timestamp: Timestamp(),
                                        type: type
        )
        
        guard let notificationData = try? Firestore.Encoder().encode(notification) else { return }
        try await ref.setData(notificationData)
    }
    
    func deleteNotification(toUid uid: String, type: NotificationType, post: Post? = nil) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid, uid != currentUid else { return }
        //Get all notifications of current user sent to uid
        let snapshot = try await FirestoreConstants.userNotificationsCollection(uid: uid)
            .whereField("notificationSenderUid", isEqualTo: currentUid)
            .getDocuments()
        
        let notifications = snapshot.documents.compactMap({ try? $0.data(as: Notification.self) })
        
        //filter the type of notification
        let filterByType = notifications.filter({ $0.type == type })
        
        
        //if type is follow then delete all the notifications
        if type == .follow {
            for notification in filterByType {
                try await FirestoreConstants.userNotificationsCollection(uid: uid).document(notification.id).delete()
            }
        } else {
            //else just delete the first notification in the array returns
            guard let notificationToDelete = filterByType.first(where: { $0.postId == post?.id }) else { return }
            try await FirestoreConstants.userNotificationsCollection(uid: uid).document(notificationToDelete.id).delete()
        }
    }
}
