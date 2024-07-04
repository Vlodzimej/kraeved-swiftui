//
//  ProfileView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

// MARK: - ProfilePageView
struct ProfilePageView: View {
    

    @State var showingAlert: Bool = false
    
    @ObservedObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                VStack {
                    VStack {
                        Form {
                            Section {
                                phoneTextField
                                startDateTextField
                            }
                            Section {
                                nameInputField
                                surnameInputField
                            }
                        }
                        .foregroundColor(Color.Kraeved.Gray.dark)
                        .scrollContentBackground(.hidden)
                        .scrollDisabled(true)
                        Spacer()
                        buttonStack
                        
                    }
                    .isVisible(isVisible: viewModel.isAuth)
                    emptyProfile
                    .isVisible(isVisible: !viewModel.isAuth)
                }
                .onAppear {
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
        KraevedTextInput(value: $viewModel.editedUser.surname, 
                         title: "profile.surname",
                         placeholder: "profile.enterName",
                         keyboardType: .alphabet,
                         titleColor: Color.Pallete.cambridgeBlue,
                         backgroundColor: Color.white,
                         innerInsets: .init(.zero))
    }
    
    private var surnameInputField: some View {
        KraevedTextInput(value: $viewModel.editedUser.name, 
                         title: "profile.name",
                         placeholder: "profile.enterSurname",
                         keyboardType: .alphabet,
                         titleColor: Color.Pallete.cambridgeBlue,
                         backgroundColor: Color.white,
                         innerInsets: .init(.zero))
    }
    
    private var startDateTextField: some View {
        VStack(alignment: .leading) {
            Text("profile.startDate")
                .font(.system(size: 12))
                .padding(.bottom, 4)
                .foregroundColor(Color.Pallete.cambridgeBlue)
            Text(CustomDateFormatter.formatToString(date: viewModel.editedUser.startDate, dateFormat: "dd.MM.yyyy") ?? "")
        }
    }
    
    private var phoneTextField: some View {
        VStack(alignment: .leading) {
            Text("common.phone")
                .font(.system(size: 12))
                .padding(.bottom, 4)
                .foregroundColor(Color.Pallete.cambridgeBlue)
            Text(PhoneFormatter.format(phoneNumber: viewModel.editedUser.phone))
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
            }
        }
        .isVisible(isVisible: viewModel.isAuth)
    }
    
    private var emptyProfile: some View {
        VStack(spacing: 20) {
            Text("profile.authorizationInfo")
            NavigationLink(destination: LoginPageView(), label: {
                Text("common.entry")
            })
            .buttonStyle(.borderedProminent)
            .tint(Color.Pallete.viridian)
        }
        .padding(16)
    }
}

#Preview {
    ProfilePageView()
}
