//
//  CreateUsernameView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 4/9/24.
//

import SwiftUI

struct CreateUsernameView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Create username")
                .font(.title2)
                .fontWeight(.heavy)
                .padding(.top)
            
            Text("You'll use this email to sign in to your account")
                .font(.footnote)
                .foregroundStyle(.gray)
            
            TextField("Username", text: $viewModel.username)
                .modifier(IGTextFieldModifier())
                .textInputAutocapitalization(.never)
                .padding(.vertical)
                
            NavigationLink {
                CreatePasswordView()
                    .navigationBarBackButtonHidden()
            } label: {
                Text("Next")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            .frame(width: 360, height: 48)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            Spacer()

        }
        .padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .onTapGesture {
                        dismiss()
                    }
                
            }
        }
    }
}

#Preview {
    CreateUsernameView()
}
