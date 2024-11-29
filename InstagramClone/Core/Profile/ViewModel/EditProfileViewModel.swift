//
//  EditProfileViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 7/9/24.
//

import SwiftUI
import PhotosUI
import FirebaseFirestore
import Kingfisher

@MainActor
class EditProfileViewModel: ObservableObject {
    //this user store the current user info
    @Published var user: User
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    @Published var profileImage: Image?
    @Published var fullname = ""
    @Published var bio = ""
    var uiImage: UIImage?
    
    init(user: User) {
        self.user = user
        self.fullname = user.fullname ?? ""
        self.bio = user.bio ?? ""
    }
    
    private func loadImage() async throws {
        guard let selectedImage else { return }
        guard let imageData = try await selectedImage.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.profileImage = Image(uiImage: uiImage)
        
        self.uiImage = uiImage
    }
    
    func updateUserData() async throws {
        var data : [String: Any] = [:]
        
        //if fullname is different from current user fullname then update it
        if !fullname.isEmpty && fullname != user.fullname ?? "" {
            data["fullname"] = fullname
        }
        
        //if bio is different from current user bio then update it
        if !bio.isEmpty && bio != user.bio ?? "" {
            data["bio"] = bio
        }
        
        //if there are any update then send it to Firebase firestore
        if !data.isEmpty {
            try await UserService.shared.updateUserData(data)
        }
        
        //upload profile image
        guard let uiImage else { return }
        guard let imageUrl = try await ImageUploader.uploadImage(uiImage) else { return }
        try await UserService.shared.updateProfileImage(imageUrl)
    }
}
