//
//  ProfileView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 3/9/24.
//

import SwiftUI

struct ProfileView: View {
    
    let user: User
    
    var body: some View {
        ScrollView {
            //Header view
            ProfileHeaderView(user: user)
        
            //Posts Grid view
            PostsGridView(user: user)
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    ProfileView(user: User.MOCK_USERS[0])
}
