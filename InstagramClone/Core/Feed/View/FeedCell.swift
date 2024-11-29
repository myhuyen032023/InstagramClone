//
//  FeedCell.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 4/9/24.
//

import SwiftUI
import Kingfisher

struct FeedCell: View {
    
    @StateObject var viewModel: FeedCellViewModel
    
    init(post: Post) {
        self._viewModel = StateObject(wrappedValue: FeedCellViewModel(post: post))
    }
    
    private var post: Post {
        return viewModel.post
    }
    
    private var didLiked: Bool {
        return post.didLike ?? false
    }
    
    @State var showComments = false
    
    var body: some View {
        VStack {
            //avatar + username
            HStack {
                
                if let user = post.user {
                    CircularProfileImage(user: user, size: .small)
                    
                    Text(user.username)
                        .font(.footnote)
                        .fontWeight(.semibold)
                }
                
                Spacer()
            }
            
            //image posts
            KFImage(URL(string: post.imageUrl))
                .resizable()
                .scaledToFill()
                .frame(width: 400, height: 400)
                .clipped()
            
            //action buttons
            HStack(spacing: 16) {
                Button {
                    handleLikeTabbed()
                } label: {
                    Image(systemName: didLiked ? "heart.fill" : "heart")
                        .imageScale(.large)
                        .foregroundStyle(didLiked ? .red : .black)
                }
                Button {
                    // show comment
                    showComments = true
                } label: {
                    Image(systemName: "bubble.right")
                        .imageScale(.large)
                }
                Button {
                    
                } label: {
                    Image(systemName: "paperplane")
                        .imageScale(.large)
                }
                
                Spacer()
            }
            .foregroundStyle(.black)
            .padding(.top, 2)
            
            //likes label
            if post.likes > 0 {
                Text("\(post.likes) likes")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 2)
            }
            
            //caption
            HStack {
                Text("\(post.user?.username ?? "") ").font(.footnote).fontWeight(.semibold) +
                Text(post.caption)
                    .font(.footnote)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 2)
            
            //timestamp
            Text(post.timestamp.timestampString())
                .font(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 2)
                .foregroundStyle(.gray)
        }
        .padding(.horizontal, 12)
        .sheet(isPresented: $showComments) {
            CommentView(post: post)
                .presentationDragIndicator(.visible)
        }
    }
    
    func handleLikeTabbed() {
        Task {
            if didLiked {
                try await viewModel.unlike()
            } else {
                try await viewModel.like()
            }
        }
    }
}

#Preview {
    FeedCell(post: Post.MOCK_POSTS[0])
}
