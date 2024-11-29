//
//  CompleteSignUpView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 4/9/24.
//

import SwiftUI

struct CompleteSignUpView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: RegistrationViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            
            Text("Welcome to Instagram, \n\(viewModel.username)")
                .font(.title2)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .padding(.top)
            
            Text("Click below to complete registration and start using instagram.")
                .font(.footnote)
                .multilineTextAlignment(.center)
            

                
            Button {
                viewModel.createUser()
            } label: {
                Text("Complete Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            .frame(width: 360, height: 48)
            .background(.blue)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            .padding(.top)
            
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
    CompleteSignUpView()
}
