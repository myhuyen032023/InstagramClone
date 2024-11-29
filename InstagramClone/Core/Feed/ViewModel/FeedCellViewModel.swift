//
//  FeedCellViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 8/9/24.
//

import Foundation

@MainActor
class FeedCellViewModel: ObservableObject {
    @Published var post: Post
    
    init(post: Post) {
        self.post = post
        Task { try await checkIfUserLikedPost() }
    }
    
    func like() async throws {
        do {
            post.didLike = true
            post.likes += 1
            try await PostService.likePost(post)
            
            try await NotificationManager.shared.uploadLikeNotification(toUid: post.ownerUid, post: post)
        } catch {
            post.didLike = false
            post.likes -= 1
        }
    }
    
    func unlike() async throws {
        do {
            post.didLike = false
            post.likes -= 1
            try await PostService.unlikePost(post)
            
            try await NotificationManager.shared.deleteLikeNotification(toUid: post.ownerUid, post: post)
        } catch {
            post.didLike = true
            post.likes += 1
        }
    }
    
    func checkIfUserLikedPost() async throws {
        post.didLike = try await PostService.checkIfUserLikedPost(post)
    }
}
