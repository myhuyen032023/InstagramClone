//
//  RegistrationViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 6/9/24.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    
    func createUser() {
        Task {
            try await AuthService.shared.createUser(email: email, password: password, username: username)
            username = ""
            email = ""
            password = ""
        } 
    }
}
