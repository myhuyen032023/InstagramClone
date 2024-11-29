//
//  MainTabBar.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 2/9/24.
//

import SwiftUI

struct MainTabBar: View {
    @State var selectedIndex = 0
    
    var body: some View {
        TabView(selection: $selectedIndex) {
            FeedView()
                .onAppear {
                    selectedIndex = 0
                }.tag(0)
                .tabItem { Image(systemName: "house") }
            
            SearchView()
                .onAppear {
                    selectedIndex = 1
                }.tag(1)
                .tabItem { Image(systemName: "magnifyingglass") }
            
            UploadPostView(selectedTab: $selectedIndex)
                .onAppear {
                    selectedIndex = 2
                }.tag(2)
                .tabItem { Image(systemName: "plus.square") }
            
            NotificationView()
                .onAppear {
                    selectedIndex = 3
                }.tag(3)
                .tabItem { Image(systemName: "heart") }
            
            CurrentUserProfileView()
                .onAppear {
                    selectedIndex = 4
                }.tag(4)
                .tabItem { Image(systemName: "person") }
        }
        .tint(.black)
    }
}

#Preview {
    MainTabBar()
}
