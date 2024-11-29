//
//  IGTextFieldModifier.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 4/9/24.
//

import SwiftUI

struct IGTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.subheadline)
            .padding(12)
            .background(Color(.systemGray6))
            .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
