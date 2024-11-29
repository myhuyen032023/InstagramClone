//
//  UserStatView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 3/9/24.
//

import SwiftUI

struct UserStatView: View {
    
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
                
            Text(title)
                .font(.footnote)
                
            
        }
        .opacity(value == 0 ? 0.5 : 1)
        .frame(width: 78)
    }
}

#Preview {
    UserStatView(value: 3, title: "Posts")
}
