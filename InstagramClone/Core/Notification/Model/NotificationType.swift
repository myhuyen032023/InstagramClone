//
//  NotificationType.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 11/9/24.
//

import Foundation

//Phai co Int thi no moi tao value mac dinh cho tung thang tu 0...
//Thi no moi luu len database gia tri mac dinh nay duoc
enum NotificationType: Int, Codable {
    case like
    case comment
    case follow
    
    var notificationMessage: String {
        switch self {
        case .like: return "liked one of your post."
        case .comment: return "commented on one of your post."
        case .follow: return "started following you."
        }
    }
}
