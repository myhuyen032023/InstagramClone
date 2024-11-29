//
//  Post.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 5/9/24.
//

import Foundation
import Firebase

struct Post: Identifiable, Codable, Hashable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    
    var user: User?
    var didLike: Bool? = false //did liked by current user
}

extension Post {
    static let MOCK_POST_IMAGE_URL = "https://firebasestorage.googleapis.com:443/v0/b/instagramclone-98e73.appspot.com/o/profile_images%2F8C12C121-F27A-4945-86DE-8DB8FA4052C7?alt=media&token=7e797813-1f0d-432b-9ef4-b09e2ce4191f"
    
    static let MOCK_POSTS: [Post] = [
        .init(id: UUID().uuidString, 
              ownerUid: UUID().uuidString,
              caption: "Hello", 
              likes: 12,
              imageUrl: "avatar", 
              timestamp: Timestamp(),
              user: User.MOCK_USERS[0]),
        .init(id: UUID().uuidString, 
              ownerUid: UUID().uuidString,
              caption: "Hello", 
              likes: 12,
              imageUrl: "avatar-1",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[1]),
        .init(id: "3", 
              ownerUid: "1",
              caption: "Hello",
              likes: 12,
              imageUrl: "avatar-2",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[2]),
        .init(id: "4", 
              ownerUid: "1",
              caption: "Hello",
              likes: 12,
              imageUrl: "avatar-2",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[2]),
        .init(id: "5", 
              ownerUid: "1",
              caption: "Hello",
              likes: 12,
              imageUrl: "avatar-3",
              timestamp: Timestamp(),
              user: User.MOCK_USERS[3]),
        
    ]
}
