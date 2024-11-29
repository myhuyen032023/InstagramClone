//
//  Notification.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 11/9/24.
//

import FirebaseFirestore

struct Notification: Identifiable, Codable {
    let id: String
    let postId: String?
    let notificationSenderUid: String
    let timestamp: Timestamp
    let type: NotificationType
    
    
    var user: User?
    var post: Post?
}

extension Notification {
    static let MOCK_NOTIFICATIONS : [Notification] = [
        .init(id: UUID().uuidString, postId: "123", notificationSenderUid: "123", timestamp: Timestamp(), type: .comment),
        .init(id: UUID().uuidString, postId: "123", notificationSenderUid: "123", timestamp: Timestamp(), type: .like),
        .init(id: UUID().uuidString, postId: "123", notificationSenderUid: "123", timestamp: Timestamp(), type: .follow),
        .init(id: UUID().uuidString, postId: "123", notificationSenderUid: "123", timestamp: Timestamp(), type: .comment),
        .init(id: UUID().uuidString, postId: "123", notificationSenderUid: "123", timestamp: Timestamp(), type: .comment),
        .init(id: UUID().uuidString, postId: "123", notificationSenderUid: "123", timestamp: Timestamp(), type: .comment),
    ]
}
