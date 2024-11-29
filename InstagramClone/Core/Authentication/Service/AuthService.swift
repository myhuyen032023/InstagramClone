//
//  AuthService.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 5/9/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthService {
    //Tao usersession de theo doi co ai dang nhap chua
    @Published var userSession: FirebaseAuth.User?
    static let shared = AuthService()
    
    init() {
        //Neu co usersession se khac nil, nguoc lai thi nil
        self.userSession = Auth.auth().currentUser
        loadUserData()
    }
    
    @MainActor
    func login(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            userSession = result.user
            
            loadUserData()
        } catch {
            print("LOGIN ERROR \(error)")
        }
    }
    
    @MainActor
    func createUser(email: String, password: String, username: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            userSession = result.user
            
            try await uploadUserData(email: email, username: username, id: result.user.uid)
            loadUserData()
        } catch {
            print("CREATE USER ERROR \(error)")
        }
    }
    
    func signOut() {
        try? Auth.auth().signOut()
        self.userSession = nil
    }
    
    private func uploadUserData(email: String, username: String, id: String) async throws {
        let user = User(id: id, username: username, email: email)
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        try await FirestoreConstants.usersCollection.document(id).setData(encodedUser)
    }
    
    func loadUserData() {
        Task { try await UserService.shared.fetchCurrentUser() }
    }
}
