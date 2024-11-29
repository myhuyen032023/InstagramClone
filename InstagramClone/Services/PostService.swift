//
//  PostService.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 7/9/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore


class PostService {
    
    static let postsCollection = FirestoreConstants.postsCollection
    
    static func uploadPost(caption: String, _ image: UIImage) async throws {
        //upload image to storage & get imageUrl
        guard let imageUrl = try await ImageUploader.uploadImage(image) else { return }
        
        //create post object with that imageUrl
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let postRef = postsCollection.document()
        let post = Post(id: postRef.documentID, ownerUid: uid, caption: caption, likes: 0, imageUrl: imageUrl, timestamp: Timestamp())
        
        //Encode the post and send to firestore
        guard let encodedPost = try? Firestore.Encoder().encode(post) else { return }
        try await postRef.setData(encodedPost)
    }
    
    static func fetchPost(withPostId pid: String) async throws -> Post {
        return try await postsCollection.document(pid).getDocument().data(as: Post.self)
    }
    
    static func fetchAllPosts() async throws -> [Post] {
        //fetch all posts in posts collection
        let snapshot = try await postsCollection.getDocuments()
        
        //Decode it
        var posts = snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
        
        //Asign the associate user with each post
        for i in 0 ..< posts.count {
            let post = posts[i]
            let uid = post.ownerUid
            let user = try await UserService.shared.fetchUser(withUid: uid)
            posts[i].user = user
        }
        
        return posts
    }
    
    static func fetchUserPosts(withUid uid: String) async throws -> [Post] {
        let snapshot = try await postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: Post.self) })
    }
}

//MARK: - Likes

extension PostService {
    static func likePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //tao collection post-likes trong document cua post chua document uid
        async let _ = FirestoreConstants.postsCollection.document(post.id).collection("post-likes").document(uid).setData([:])
        
        //update likes trong post document
        async let _ = FirestoreConstants.postsCollection.document(post.id).updateData([
            "likes": post.likes
        ])
        
        //tao collection user-likes trong document cua user chua document post.id
        async let _ = FirestoreConstants.usersCollection.document(uid).collection("user-likes").document(post.id).setData([:])
    }
    
    static func unlikePost(_ post: Post) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        //tao collection post-likes trong document cua post chua document uid
        async let _ = FirestoreConstants.postsCollection.document(post.id).collection("post-likes").document(uid).delete()
        
        //update likes trong post document
        async let _ = FirestoreConstants.postsCollection.document(post.id).updateData([
            "likes": post.likes
        ])
        
        //tao collection user-likes trong document cua user chua document post.id
        async let _ = FirestoreConstants.usersCollection.document(uid).collection("user-likes").document(post.id).delete()
    }
    
    static func checkIfUserLikedPost(_ post: Post) async throws -> Bool {
        guard let uid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await FirestoreConstants.usersCollection.document(uid).collection("user-likes").document(post.id).getDocument()
        return snapshot.exists
    }
}
