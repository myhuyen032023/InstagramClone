//
//  UploadPostView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 5/9/24.
//

import SwiftUI
import PhotosUI

struct UploadPostView: View {
    
    @State var isShowImagePicker = false
    @StateObject var viewModel = UploadPostViewModel()
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            //action buttons
            HStack {
                Button("Cancel") {
                    viewModel.clearPostData()
                    selectedTab = 0
                }
                
                Spacer()
                
                Text("New Post")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button("Upload") {
                    Task {
                        try await viewModel.uploadPost()
                        viewModel.clearPostData()
                        selectedTab = 0
                    }
                    
                }
            }
            
            
            //post image + caption
            HStack {
                if let postImage = viewModel.postImage {
                    postImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipped()
                }
                
                TextField("Enter your caption", text: $viewModel.caption, axis: .vertical)
                    
            }
            .padding(.vertical)
            
            Spacer()
        }
        .onAppear {
            isShowImagePicker = true
        }
        .photosPicker(isPresented: $isShowImagePicker, selection: $viewModel.selectedImage)
        .padding(.horizontal)
    }
}

#Preview {
    UploadPostView(selectedTab: .constant(0))
}
