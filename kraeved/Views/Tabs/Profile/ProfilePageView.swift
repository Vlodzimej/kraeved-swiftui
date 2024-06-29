//
//  ProfileView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

// MARK: - ProfilePageView
struct ProfilePageView: View {
    
    @State var isAuth: Bool = false
    @State var showingAlert: Bool = false
    
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.Kraeved.cellBackground
                VStack {
                    NavigationLink(destination: LoginPageView(), label: {
                        Text("common.entry")
                    })
                    .isVisible(isVisible: !isAuth)
                    KraevedButton(title: "profile.logout") {
                        viewModel.logout()
                        isAuth = false
                    }
                    .isVisible(isVisible: isAuth)
                }
            }
            .onAppear {
                isAuth = UserDefaults.standard.bool(forKey: "isAuth")
                showingAlert = true
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ProfilePageView()
}
