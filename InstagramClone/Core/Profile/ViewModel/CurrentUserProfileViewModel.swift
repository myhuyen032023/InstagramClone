//
//  CurrentUserProfileViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 6/9/24.
//

import Foundation
import Combine

@MainActor
class CurrentUserProfileViewModel: ObservableObject {
    @Published var currentUser: User?
    var cancellables = Set<AnyCancellable>()
    let service = UserService.shared
    
    init() {
        setupSubscribers()
    }
    
    func setupSubscribers() {
        service.$currentUser.sink { [weak self] currentUser in
            guard let self else { return }
            self.currentUser = currentUser
        }.store(in: &cancellables)
    }
}
