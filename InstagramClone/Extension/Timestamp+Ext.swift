//
//  Timestamp+Ext.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 9/9/24.
//

import Firebase

extension Timestamp {
    func timestampString() -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.second, .minute, .hour, .day, .weekOfMonth]
        formatter.unitsStyle = .abbreviated
        formatter.maximumUnitCount = 1
        return formatter.string(from: self.dateValue(), to: Date()) ?? ""
    }
}
