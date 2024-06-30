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
    
    private let nameMaxSymbolsLimit: Int = 16
    private let surnameMaxSymbolsLimit: Int = 16
    
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
        GenericTextInput(value: $viewModel.editedUser.surname, 
                         title: "profile.surname",
                         placeholder: "profile.enterName",
                         keyboardType: .alphabet,
                         limitText: nameMaxSymbolsLimit)
    }
    
    private var surnameInputField: some View {
        GenericTextInput(value: $viewModel.editedUser.name, 
                         title: "profile.name",
                         placeholder: "profile.enterSurname",
                         keyboardType: .alphabet,
                         limitText: surnameMaxSymbolsLimit)
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
                isAuth = false
            }
        }
        .isVisible(isVisible: isAuth)
    }
}

#Preview {
    ProfilePageView()
}
