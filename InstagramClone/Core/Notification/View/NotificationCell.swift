//
//  NotificationCell.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 11/9/24.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    let notification: Notification
    
    var body: some View {
        HStack {
            //avatar
            NavigationLink(value: notification.user) {
                CircularProfileImage(user: notification.user, size: .small)
            }
            
            //notification message
            Text(notification.user?.username ?? "")
                .font(.subheadline)
                .fontWeight(.semibold) +
            
            Text(" \(notification.type.notificationMessage)")
                .font(.subheadline) +
            
            Text(" \(notification.timestamp.timestampString())")
                .font(.footnote)
                .foregroundStyle(.gray)
            
            Spacer()
            //Image or Follow button
            if notification.type == .follow {
                Button {
                    
                } label: {
                    Text("Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 80, height: 28)
                        .foregroundStyle(.white)
                        .background(Color(.systemBlue))
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                }
            } else {
                NavigationLink(value: notification.post) {
                    KFImage(URL(string: notification.post?.imageUrl ?? ""))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .padding(.leading, 2)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NotificationCell(notification: Notification.MOCK_NOTIFICATIONS[0])
}
