//
//  EditProfileView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 7/9/24.
//

import SwiftUI
import PhotosUI

struct EditProfileView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel : EditProfileViewModel
    @State var user: User
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: EditProfileViewModel(user: user))
        self.user = user
    }
    
    var body: some View {
        VStack {
            //tool bar
            HStack {
                Button("Cancel") {
                    dismiss()
                }
                
                Spacer()
                
                Text("Edit Profile")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    Task {
                        try await viewModel.updateUserData()
                        dismiss()
                    }
                    
                } label: {
                     Text("Done")
                        .fontWeight(.bold)
                }
            }
            .padding(.horizontal)
            
            Divider()
            
            //profile photopicker + text
            PhotosPicker(selection: $viewModel.selectedImage) {
                VStack {
                    if let profileImage = viewModel.profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                            
                    } else {
                        CircularProfileImage(user: user, size: .xLarge)
                    }
                    
                    Text("Edit profile picture")
                        .font(.footnote)
                        .fontWeight(.bold)
                }
                .padding(.vertical, 8)
            }
            
            Divider()
            
            
            //fullname + bio edit
            EditProfileRowView(title: "Name", placeholder: "Enter your fullname...", text: $viewModel.fullname)
            
            EditProfileRowView(title: "Bio", placeholder: "Enter your bio...", text: $viewModel.bio)
            
            Spacer()
        }
    }
}

struct EditProfileRowView: View {
    
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .font(.subheadline)
            
            Spacer()
            
            VStack {
                TextField(placeholder, text: $text)
                    .font(.footnote)
        
                Divider()
            }
            .frame(width: 280)
        }
        .padding(8)
    }
}

#Preview {
    EditProfileView(user: User.MOCK_USERS[0])
}
