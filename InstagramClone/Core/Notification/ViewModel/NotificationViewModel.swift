//
//  NotificationViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 11/9/24.
//

import Foundation

@MainActor
class NotificationViewModel: ObservableObject {
    @Published var notifications: [Notification] = []
    
    private let service: NotificationService
    
    private let currentUser: User?
    
    init(service: NotificationService) {
        self.service = service
        self.currentUser = UserService.shared.currentUser
        Task { try await fetchNotifications() }
    }
    
    func fetchNotifications() async throws {
        self.notifications = try await service.fetchNotifications()
        try await updateNotifications()
    }
    
    func updateNotifications() async throws {
        for i in 0 ..< notifications.count {
            var notification = notifications[i]
            notification.user = try await UserService.shared.fetchUser(withUid: notification.notificationSenderUid)
            
            if let postId = notification.postId {
                notification.post = try await PostService.fetchPost(withPostId: postId)
                notification.post?.user = currentUser
            }
            
            notifications[i] = notification
        }
    }
}
