//
//  LoginView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 4/9/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var viewModel = LoginViewModel()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                //logo image
                Image("instagram")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 150, height: 80)
                
                //inputs
                VStack {
                    TextField("Enter your email", text: $viewModel.email)
                        .modifier(IGTextFieldModifier())
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $viewModel.password)
                        .modifier(IGTextFieldModifier())
                }
                
                
                
                //forgot password
                Text("Forgot password?")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(.blue)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.vertical)
                
                //button
                Button {
                    viewModel.login()
                } label: {
                    Text("Log In")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                .frame(width: 360, height: 48)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                //or
                
                HStack {
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                    Text("Or")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Rectangle()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 40, height: 0.5)
                }
                .foregroundStyle(.gray)
                .padding(.vertical)
                
                //login with facebook
                HStack {
                    Image("facebook")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                    
                    Text("Continue with Facebook")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(.blue)
                }
                Spacer()
                
                Divider()
                
                //sign up link
                NavigationLink {
                    AddEmailView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Don't have an account?")
                        Text("Sign Up")
                            .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .foregroundStyle(.blue)
                    .padding(.top)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    LoginView()
}
