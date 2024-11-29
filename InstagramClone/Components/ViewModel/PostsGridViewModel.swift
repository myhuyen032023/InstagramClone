//
//  PostGridViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 7/9/24.
//

import Foundation

class PostsGridViewModel: ObservableObject {
    @Published var posts: [Post] = []
    let user: User
    

    init(user: User) {
        self.user = user
        Task { try await fetchUserPosts() }
    }
    
    @MainActor
    func fetchUserPosts() async throws {
        posts = try await PostService.fetchUserPosts(withUid: user.id)
        for i in 0 ..< posts.count {
            posts[i].user = user
        }
    }
}
