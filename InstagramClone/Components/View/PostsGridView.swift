//
//  PostsGridView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 5/9/24.
//

import SwiftUI
import Kingfisher

struct PostsGridView: View {
    
    let imageDimension: CGFloat = (UIScreen.main.bounds.width / 3) - 1

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @StateObject var viewModel: PostsGridViewModel
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: PostsGridViewModel(user: user))
    }
    
    var body: some View {
        //Posts Grid view
        LazyVGrid(columns: columns, spacing: 4) {
            ForEach(viewModel.posts) { post in
                KFImage(URL(string: post.imageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: imageDimension, height: imageDimension)
                    .clipped()
            }
        }
    }
}

#Preview {
    PostsGridView(user: User.MOCK_USERS[0])
}
