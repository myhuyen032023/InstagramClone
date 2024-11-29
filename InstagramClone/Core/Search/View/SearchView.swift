//
//  SearchView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 4/9/24.
//

import SwiftUI

struct SearchView: View {
    
    var body: some View {
        NavigationStack {
            UserListView(config: .explore)
        }
    }
}

#Preview {
    SearchView()
}
