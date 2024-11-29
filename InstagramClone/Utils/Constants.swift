//
//  Constants.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 9/9/24.
//

import FirebaseFirestore

struct FirestoreConstants {
    static let Root = Firestore.firestore()
    
    static let usersCollection = Root.collection("users")
    
    static let postsCollection = Root.collection("posts")
    
    static let followingCollection = Root.collection("following")
    static let followersCollection = Root.collection("followers")
    
    static let notificationsCollection = Root.collection("notifications")
    
    static func userNotificationsCollection(uid: String) -> CollectionReference {
        return FirestoreConstants.notificationsCollection.document(uid).collection("user-notifications")
    }
}

