//
//  CommentService.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 8/9/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class CommentService {
    
    let postId: String
    let postsCollection = FirestoreConstants.postsCollection
    
    init(postId: String) {
        self.postId = postId
    }
    
    func uploadComment(_ comment: Comment) async throws {
        let commentRef = postsCollection.document(postId).collection("post-comments").document()
        guard let encodedComment = try? Firestore.Encoder().encode(comment) else { return }
        try await commentRef.setData(encodedComment)
    }
    
    func fetchComments() async throws -> [Comment] {
        //Lay query den collection posts-comments cua post hien tai
        let snapshot = try await postsCollection.document(postId).collection("post-comments").order(by: "timestamp", descending: true).getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: Comment.self)} )
    }
    
    //MARK: Test cach lam addSnapshotListener
    @Published var documentChanges: [DocumentChange] = []
    
    func observeComments() {
        let query = postsCollection.document(postId).collection("post-comments").order(by: "timestamp", descending: false)
        
        //Cho no lang nghe thay doi real-time
        query.addSnapshotListener { snapshot, _ in
            guard let changes = snapshot?.documentChanges.filter({ $0.type == .added }) else { return }
            self.documentChanges = changes
        }
    }
    /// cảm nhận cá nhân thì thấy cách làm này nó cũng không hiệu quả hơn cách gọi fetchComments cho mỗi lần uploadComment, nhưng cách làm này mang tính trải nghiệm là chính
}
