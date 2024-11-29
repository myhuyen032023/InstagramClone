//
//  UploadPostViewModel.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 5/9/24.
//

import SwiftUI
import PhotosUI

@MainActor
class UploadPostViewModel: ObservableObject {
    @Published var selectedImage: PhotosPickerItem? {
        didSet { Task { try await loadImage() } }
    }
    
    @Published var caption = ""
    @Published var postImage: Image?
    var uiImage: UIImage?
    
    private func loadImage() async throws {
        guard let selectedImage else { return }
        guard let imageData = try await selectedImage.loadTransferable(type: Data.self) else { return }
        guard let uiImage = UIImage(data: imageData) else { return }
        self.uiImage = uiImage
        self.postImage = Image(uiImage: uiImage)
    }
    
    func uploadPost() async throws {
        guard let uiImage else { return }
        try await PostService.uploadPost(caption: caption, uiImage)
    }
    
    func clearPostData() {
        caption = ""
        postImage = nil
        selectedImage = nil
    }
}
