//
//  ImageUploader.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 7/9/24.
//

import UIKit
import FirebaseStorage

class ImageUploader {
    
    //Ham nay upload image len FirebaseStorage sau do download url va tra ve string cua url do
    static func uploadImage(_ image: UIImage) async throws -> String? {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return nil }
        let filename = UUID().uuidString
        let ref = Storage.storage().reference(withPath: "/profile_images/\(filename)")
        
        let _ = try await ref.putDataAsync(imageData)
        let url = try await ref.downloadURL()
        return url.absoluteString
    }
}

