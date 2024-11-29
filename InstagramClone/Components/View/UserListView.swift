//
//  UserListView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 10/9/24.
//

import SwiftUI

struct UserListView: View {
    
    @StateObject var viewModel: UserListViewModel
    
    init(config: UserListConfig) {
        self._viewModel = StateObject(wrappedValue: UserListViewModel(config: config))
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                
                ForEach(viewModel.users) { user in
                    NavigationLink(value: user) {
                        HStack {
                            CircularProfileImage(user: user, size: .small)
                            
                            VStack(alignment: .leading, spacing: 0) {
                                Text(user.username)
                                    .font(.footnote)
                                    .fontWeight(.bold)
                                if let fullname = user.fullname {
                                    Text(fullname)
                                        .font(.footnote)
                                }
                            }
                
                            Spacer()
                        }
                        .padding(.leading, 16)
                    }

                }
            }
        }
        .padding(.top)
        .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search...")
        .navigationTitle(viewModel.config.navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: User.self, destination: { user in
            ProfileView(user: user)
        })
    }
}

#Preview {
    UserListView(config: .explore)
}
