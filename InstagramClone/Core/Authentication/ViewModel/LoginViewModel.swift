//
//  LoginViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 6/9/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func login() {
        Task { try await AuthService.shared.login(email: email, password: password) }
    }
}
