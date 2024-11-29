//
//  AddEmailView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 4/9/24.
//

import SwiftUI

struct AddEmailView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Add your email")
                .font(.title2)
                .fontWeight(.heavy)
                .padding(.top)
            
            Text("You'll use this email to sign in to your account")
                .font(.footnote)
                .foregroundStyle(.gray)
            
            TextField("Email", text: $viewModel.email)
                .modifier(IGTextFieldModifier())
                .textInputAutocapitalization(.never)
                
                .padding(.vertical)
                
            NavigationLink {
                CreateUsernameView()
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
    AddEmailView()
}
