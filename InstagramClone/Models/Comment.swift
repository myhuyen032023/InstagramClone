//
//  Comment.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 8/9/24.
//

import Foundation
import FirebaseFirestore

struct Comment: Identifiable, Codable {
    @DocumentID var commentId: String?
    let commentOwnerUid: String
    let commentText: String
    let postId: String
    let postOwnerUid: String
    let timestamp: Timestamp
    
    var user: User?
    
    var id: String {
        return commentId ?? UUID().uuidString
    }
}

extension Comment {
    static let MOCK_COMMENT = Comment(commentOwnerUid: UUID().uuidString, commentText: "Test comment", postId: UUID().uuidString, postOwnerUid: UUID().uuidString, timestamp: Timestamp())
}
