//
//  User.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 5/9/24.
//

import SwiftUI
import FirebaseAuth

struct User: Identifiable, Codable, Hashable {
    let id: String
    var username: String
    var fullname: String?
    var profileImageUrl: String?
    var bio: String?
    let email: String
    
    var isFollowed: Bool?
    
    var stats: UserStats?
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false}
        return id == currentUid
    }
}

struct UserStats: Codable, Hashable {
    var followerCount: Int
    var followingCount: Int
    var postCount: Int
}

extension User {
    static let MOCK_USERS: [User]  = [
        User(id: UUID().uuidString, username: "myhuyen", fullname: "My Huyen", profileImageUrl: nil, bio: "My huyen bio", email: "myhuyen@gmail.com"),
        User(id: UUID().uuidString, username: "test1", fullname: "Test1", profileImageUrl: nil, bio: "test1 bio", email: "test1@gmail.com"),
        User(id: UUID().uuidString, username: "test2", fullname: "Test2", profileImageUrl: nil, bio: "Test2 bio", email: "test2@gmail.com"),
        User(id: UUID().uuidString, username: "test3", fullname: "Test3", profileImageUrl: nil, bio: "Test3 bio", email: "test3@gmail.com"),
        User(id: UUID().uuidString, username: "hello", bio: "Test bio", email: "myhuyen@gmail.com"),
    ]
}
