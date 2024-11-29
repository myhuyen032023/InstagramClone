//
//  CreatePasswordView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 4/9/24.
//

import SwiftUI

struct CreatePasswordView: View {

    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Create password")
                .font(.title2)
                .fontWeight(.heavy)
                .padding(.top)
            
            Text("Your password must be at least 6 charaters in length.")
                .font(.footnote)
                .foregroundStyle(.gray)
            
            SecureField("Password", text: $viewModel.password)
                .modifier(IGTextFieldModifier())
                .textInputAutocapitalization(.none)
                .padding(.vertical)
                
            NavigationLink {
                CompleteSignUpView()
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
    CreatePasswordView()
}
