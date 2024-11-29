//
//  NotificationManager.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 11/9/24.
//

import Foundation

class NotificationManager {
    let service = NotificationService()
    static let shared = NotificationManager()
    
    func uploadCommentNotification(toUid uid: String, post: Post) async throws {
        try await service.uploadNotification(toUid: uid, type: .comment, post: post)
    }
    
    func uploadLikeNotification(toUid uid: String, post: Post) async throws {
        try await service.uploadNotification(toUid: uid, type: .like, post: post)
    }
    
    func uploadFollowNotification(toUid uid: String) async throws {
        try await service.uploadNotification(toUid: uid, type: .follow)
    }
    
    func deleteLikeNotification(toUid uid: String, post: Post) async throws {
        try await service.deleteNotification(toUid: uid, type: .like, post: post)
    }
    
    func deleteFollowNotification(toUid uid: String) async throws {
        try await service.deleteNotification(toUid: uid, type: .follow)
    }
}
