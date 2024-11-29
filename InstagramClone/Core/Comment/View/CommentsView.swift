//
//  CommentView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 8/9/24.
//

import SwiftUI

struct CommentView: View {
    
    @StateObject var viewModel: CommentViewModel
    
    init(post: Post) {
        self._viewModel = StateObject(wrappedValue: CommentViewModel(post: post))
    }
    
    var currentUser: User? {
        return UserService.shared.currentUser
    }
    
    var body: some View {
        VStack {
            //comment header
            Text("Comments")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top)
            
            Divider()
            
            //scrollview
            ScrollView {
                LazyVStack {
                    ForEach(viewModel.comments) { comment in
                        CommentCell(comment: comment)
                    }
                }
            }
            
            Divider()
            
            //comment section
            HStack {
                //avatar
                CircularProfileImage(user: currentUser, size: .small)
                //comment textfield + send button
                ZStack(alignment: .trailing) {
                    TextField("Add a comment...", text: $viewModel.commentText, axis: .vertical)
                        .font(.subheadline)
                        .padding(8)
                        .padding(.trailing, 48)
                        .overlay {
                            RoundedRectangle(cornerRadius: 24)
                                .stroke(Color(.systemGray5), lineWidth: 1)
                        }
                    
                    Button {
                        Task {
                            try await viewModel.uploadComment()
                            viewModel.commentText = ""
                        }
                    } label: {
                        Text("Send")
                            .font(.footnote)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.systemBlue))
                            .padding()
                    }
                }
                
            }
            .padding(.horizontal)
            .padding(.top, 4)
        }
    }
}

#Preview {
    CommentView(post: Post.MOCK_POSTS[0])
}
