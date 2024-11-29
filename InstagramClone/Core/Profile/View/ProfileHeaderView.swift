//
//  ProfileHeaderView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 5/9/24.
//

import SwiftUI

struct ProfileHeaderView: View {
    
    @State var isShowEditProfileView = false
    @ObservedObject var viewModel : ProfileViewModel
    
    init(user: User) {
        self.viewModel = ProfileViewModel(user: user)
    }
    
    private var user: User {
        return viewModel.user
    }
    
    private var isFollowed: Bool {
        return user.isFollowed ?? false
    }
    
    private var stats: UserStats {
        return user.stats ?? .init(followerCount: 0, followingCount: 0, postCount: 0)
    }
    
    private var buttonTitle: String {
        if user.isCurrentUser {
            return "Edit Profile"
        } else if isFollowed {
            return "Following"
        } else {
            return "Follow"
        }
    }
    
    private var buttonBackgroundColor: Color {
        if user.isCurrentUser || isFollowed {
            return .white
        } else {
            return Color(.systemBlue)
        }
    }
    
    private var buttonforegroundStyle: Color {
        if user.isCurrentUser || isFollowed {
            return .black
        } else {
            return .white
        }
    }
    
    var body: some View {
        //Header view
        VStack(spacing: 10) {
            HStack(spacing: 10) {
                //avatar & stats
                CircularProfileImage(user: user, size: .xLarge)
                
                Spacer()
                
                HStack(spacing: 10) {
                    UserStatView(value: stats.postCount, title: "Posts")
                    NavigationLink(value: UserListConfig.followers(uid: user.id)) {
                        UserStatView(value: stats.followerCount, title: "Followers")
                    }
                    
                    NavigationLink(value: UserListConfig.following(uid: user.id)) {
                        UserStatView(value: stats.followingCount, title: "Following")
                    }
                    
                }
                
            }
            .padding(.horizontal)
            
            //username & bio
            VStack(alignment: .leading) {
                Text(user.username)
                    .font(.footnote)
                    .fontWeight(.semibold)
                Text(user.bio ?? "")
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 20)
            
            //Button
            Button {
                if user.isCurrentUser {
                    isShowEditProfileView = true
                } else {
                    followButtonTabbed()
                }
            } label: {
                Text(buttonTitle)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .frame(width: 360, height: 32)
                    .background(buttonBackgroundColor)
                    .foregroundStyle(buttonforegroundStyle)
                    .overlay {
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray, lineWidth: 1)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }

            
            Divider()
        }
        .navigationDestination(for: UserListConfig.self, destination: { config in
            UserListView(config: config)
        })
        .fullScreenCover(isPresented: $isShowEditProfileView) {
            EditProfileView(user: user)
        }
    }
    
    func followButtonTabbed() {
        if isFollowed {
            viewModel.unfollow()
        } else {
            viewModel.follow()
        }
    }
}

#Preview {
    ProfileHeaderView(user: User.MOCK_USERS[2])
}
