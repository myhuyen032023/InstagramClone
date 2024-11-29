//
//  UserService.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 6/9/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class UserService {
    @Published var currentUser: User?
    static let shared = UserService()
    
    let usersCollection = FirestoreConstants.usersCollection
    
    @MainActor
    func fetchCurrentUser() async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let snapshot = try await usersCollection.document(uid).getDocument()
        let user = try? snapshot.data(as: User.self)
        self.currentUser = user
    }
    
    func fetchAllUsers() async throws -> [User] {
        let snapshot = try await usersCollection.getDocuments()
        return snapshot.documents.compactMap({ try? $0.data(as: User.self) })
    }
    
    @MainActor
    func updateUserData(_ data: [String : Any]) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await usersCollection.document(uid).updateData(data)
        
        
        if let fullname = data["fullname"] {
            currentUser?.fullname = fullname as? String
        }
        if let bio = data["bio"] {
            currentUser?.bio = bio as? String
        }
    }
    
    @MainActor
    func updateProfileImage(_ imageUrl: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        try await usersCollection.document(uid).updateData([
            "profileImageUrl": imageUrl
        ])
        
        currentUser?.profileImageUrl = imageUrl
    }
    
    func fetchUser(withUid uid: String) async throws -> User {
        let snapshot = try await usersCollection.document(uid).getDocument()
        return try snapshot.data(as: User.self)
    }
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        usersCollection.document(uid).getDocument{ snapshot, error in
            guard let user = try? snapshot?.data(as: User.self) else { return }
            completion(user)
        }
    }
    
    func fetchUsers(forConfig config: UserListConfig) async throws -> [User] {
        switch config {
        case .followers(uid: let uid):
            return try await fetchFollowers(uid: uid)
        case .following(uid: let uid):
            return try await fetchFollowing(uid: uid)
        case .likes(postId: let postId):
            return try await fetchPostLikesUsers(postId: postId)
        case .explore:
            return try await fetchAllUsers()
        }
    }
    
    private func fetchFollowers(uid: String) async throws -> [User] {
        let snapshot = try await FirestoreConstants.followersCollection.document(uid).collection("user-followers").getDocuments()
        
        print("fetch followers...")
        return try await fetchUsers(withSnapshot: snapshot)
    }
    
    private func fetchFollowing(uid: String) async throws -> [User] {
        let snapshot = try await FirestoreConstants.followingCollection.document(uid).collection("user-following").getDocuments()
        print("fetch following...")
        return try await fetchUsers(withSnapshot: snapshot)
    }
    
    private func fetchPostLikesUsers(postId: String) async throws -> [User] {
        return []
    }
    
    private func fetchUsers(withSnapshot snapshot: QuerySnapshot) async throws -> [User] {
        var users = [User]()
        
        for doc in snapshot.documents {
            users.append(try await fetchUser(withUid: doc.documentID))
        }
        
        return users
    }
}


//MARK: - Following Functions
extension UserService {
    static func follow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        async let _ = FirestoreConstants.followingCollection.document(currentUid).collection("user-following").document(uid).setData([:])
        async let _ = FirestoreConstants.followersCollection.document(uid).collection("user-followers").document(currentUid).setData([:])
    }
    
    static func unfollow(uid: String) async throws {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        async let _ = FirestoreConstants.followingCollection.document(currentUid).collection("user-following").document(uid).delete()
        async let _ = FirestoreConstants.followersCollection.document(uid).collection("user-followers").document(currentUid).delete()
    }
    
    static func checkIfUserIsFollowed(uid: String) async throws -> Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        let snapshot = try await FirestoreConstants.followingCollection.document(currentUid).collection("user-following").document(uid).getDocument()
        return snapshot.exists
    }
}


//MARK: - User stats
extension UserService {
    static func fetchUserStats(uid: String) async throws -> UserStats {
        async let followingCount = FirestoreConstants.followingCollection.document(uid).collection("user-following").getDocuments().count
        
        async let followerCount = FirestoreConstants.followersCollection.document(uid).collection("user-followers").getDocuments().count
        
        async let postCount = FirestoreConstants.postsCollection.whereField("ownerUid", isEqualTo: uid).getDocuments().count
        print("Fetch user stats...")
        return try await UserStats(followerCount: followerCount, followingCount: followingCount, postCount: postCount)
    }
}
