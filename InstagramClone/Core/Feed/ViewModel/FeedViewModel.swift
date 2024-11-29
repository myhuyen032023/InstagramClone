//
//  FeedViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 7/9/24.
//

import Foundation

@MainActor
class FeedViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    
    init() {
        Task { try await fetchAllPosts() }
    }
    
    func fetchAllPosts() async throws {
        self.posts = try await PostService.fetchAllPosts()
    }
}
