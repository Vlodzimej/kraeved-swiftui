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
    
    private let userNameLength: Int = 16
    private let userSurnameLength: Int = 16
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.Kraeved.cellBackground
                VStack {
                    VStack {
                        Form {
                            Section {
                                nameInputField
                                surnameInputField
                            }
                            Section {
                                phoneTextField
                                startDateTextField
                            }
                        }
                        .foregroundColor(Color.Kraeved.darkGrey)
                        .background(Color.Kraeved.cellBackground)
                        .scrollContentBackground(.hidden)
                        .scrollDisabled(true)
                        Spacer()
                        buttonStack
                        
                    }
                    .isVisible(isVisible: isAuth)
                    Spacer()
                    NavigationLink(destination: LoginPageView(), label: {
                        Text("common.entry")
                    })
                    .isVisible(isVisible: !isAuth)
                }
                .onAppear {
                    isAuth = UserDefaults.standard.bool(forKey: "isAuth")
                    showingAlert = true
                    viewModel.getCurrentUser()
                }
                .disabled(viewModel.isLoading)
                ProgressView()
                    .controlSize(.large)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .isVisible(isVisible: viewModel.isLoading)
            }
        }
    }
    
    private var nameInputField: some View {
        GenericTextInput(value: $viewModel.editedUser.surname, title: "profile.surname", placeholder: "", keyboardType: .alphabet)
            .onChange(of: viewModel.editedUser.name) {
                handleNameChange()
            }
    }
    
    private var surnameInputField: some View {
        GenericTextInput(value: $viewModel.editedUser.name, title: "profile.name", placeholder: "", keyboardType: .alphabet)
            .onChange(of: viewModel.editedUser.surname) {
                handleSurnameChange()
            }
    }
    
    private var startDateTextField: some View {
        VStack(alignment: .leading) {
            Text("profile.startDate")
                .font(.system(size: 12))
                .padding(.bottom, 4)
                .foregroundColor(Color.Kraeved.mainStroke)
            Text(CustomDateFormatter.formatToString(date: viewModel.editedUser.startDate, dateFormat: "dd.MM.yyyy") ?? "")
        }
    }
    
    private var phoneTextField: some View {
        VStack(alignment: .leading) {
            Text("common.phone")
                .font(.system(size: 12))
                .padding(.bottom, 4)
                .foregroundColor(Color.Kraeved.mainStroke)
            Text(viewModel.editedUser.phone)
        }
    }
    
    private var buttonStack: some View {
        VStack {
            KraevedButton(title: "common.update") {
                viewModel.patchCurrentUser()
            }
            .isVisible(isVisible: viewModel.hasChanges)
            KraevedButton(title: "profile.logout") {
                viewModel.logout()
                isAuth = false
            }
        }
        .isVisible(isVisible: isAuth)
    }
    
    private func handleNameChange() {
        viewModel.editedUser.name = String(viewModel.editedUser.name.prefix(userNameLength))
    }
    
    private func handleSurnameChange() {
        viewModel.editedUser.surname = String(viewModel.editedUser.surname.prefix(userSurnameLength))
    }
}

#Preview {
    ProfilePageView()
}
