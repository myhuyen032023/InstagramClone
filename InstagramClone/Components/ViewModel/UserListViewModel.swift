//
//  UserListViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 10/9/24.
//

import Foundation
@MainActor
class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var searchText = ""
    
    let service = UserService.shared
    var config: UserListConfig
    
    init(config: UserListConfig) {
        self.config = config
        fetchUsers()
        print("Fetch users...")
    }
    
    func fetchUsers() {
        Task { self.users = try await service.fetchUsers(forConfig: config) }
    }
}
