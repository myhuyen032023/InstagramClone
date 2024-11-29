//
//  ContentView.swift
//  InstagramClone
//
//  Created by Hoang Thi My Huyen on 2/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewModel()
    @StateObject var registrationViewModel = RegistrationViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession == nil {
                LoginView()
                    .environmentObject(registrationViewModel)
            } else {
                MainTabBar()
            }
        }
    }
}

#Preview {
    ContentView()
}
