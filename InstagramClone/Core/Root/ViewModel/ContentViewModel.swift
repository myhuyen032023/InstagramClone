//
//  ContentViewMoel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 5/9/24.
//

import Foundation
import FirebaseAuth
import Combine

class ContentViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    var cancellables = Set<AnyCancellable>()
    
    let service = AuthService.shared
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        service.$userSession.sink { [weak self] userFromAuthService in
            guard let self else { return }
            self.userSession = userFromAuthService
        }.store(in: &cancellables)
    }
}
