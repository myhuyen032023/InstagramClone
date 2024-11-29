//
//  CommentViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 8/9/24.
//

import Foundation
import FirebaseAuth
import Firebase

import Combine

@MainActor
class CommentViewModel: ObservableObject {
    @Published var comments: [Comment] = []
    @Published var commentText = ""
    
    let post: Post
    let service: CommentService
    
    init(post: Post) {
        self.post = post
        service = CommentService(postId: post.id)
        Task { try await fetchComments() }
        
//        setupSubscribers()
//        service.observeComments()
    }
    
    var cancellabes = Set<AnyCancellable>()
    
    func uploadComment() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let comment = Comment(
            commentOwnerUid: uid,
            commentText: commentText,
            postId: post.id,
            postOwnerUid: post.ownerUid, 
            timestamp: Timestamp()
        )
        
        try await service.uploadComment(comment)
        try await fetchComments()
        
        try await NotificationManager.shared.uploadCommentNotification(toUid: post.ownerUid, post: post)
    }
    
    func fetchComments() async throws {
        self.comments = try await service.fetchComments()
        try await fetchUserForComment()
    }
    
    func fetchUserForComment() async throws {
        for i in 0 ..< comments.count {
            let comment = comments[i]
            let uid = comment.commentOwnerUid
            let user = try await UserService.shared.fetchUser(withUid: uid)
            comments[i].user = user
        }
    }
    
    //MARK: - test cach lam addSnapshotListener
    func setupSubscribers() {
        service.$documentChanges.sink { [weak self] changes in
            self?.updateComments(changes)
        }.store(in: &cancellabes)
    }
    
    func updateComments(_ changes: [DocumentChange]) {
        var comments = changes.compactMap({ try? $0.document.data(as: Comment.self)})
        
        for i in 0 ..< comments.count {
            let comment = comments[i]
            UserService.shared.fetchUser(withUid: comment.commentOwnerUid) { [weak self] user in
                comments[i].user = user
                self?.comments.insert(comments[i], at: 0)
            }
        }
    }
}
