//
//  CommentCell.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 8/9/24.
//

import SwiftUI

struct CommentCell: View {
    
    let comment: Comment
    
    var user: User? {
        return comment.user
    }
    
    var body: some View {
        HStack {
            //avatar
            
            CircularProfileImage(user: user, size: .xSmall)
            
            
            VStack(alignment: .leading) {
                //username + timestamp
                HStack {
                    Text(user?.username ?? "")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    Text(comment.timestamp.timestampString())
                        .font(.footnote)
                        .foregroundStyle(.gray)
                }
                //comment
                Text(comment.commentText)
                    .font(.footnote)
            }
            
            Spacer()
            
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

#Preview {
    CommentCell(comment: Comment.MOCK_COMMENT)
}
