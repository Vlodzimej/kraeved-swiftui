//
//  LoginEmailPageView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 05.05.2025.
//

import SwiftUI

// MARK: - LoginEmailPageView
struct LoginEmailPageView: View {

    @ObservedObject private var viewModel = ViewModel()
    @Environment(\.dismiss) var dismiss
    @State var showingAlert: Bool = false
    
    var body: some View {
        NavigationStack {
        ZStack {
            Color.white
            VStack {
                formContent
                errorMessage
                buttons
            }
            .frame(alignment: .top)
            .disabled(viewModel.isLoading)
            ProgressView()
                .controlSize(.large)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .isVisible(isVisible: viewModel.isLoading)
        }
        .alert("login.success", isPresented: $showingAlert) {
            Button("common.return", role: .cancel) {
                dismiss()
            }
        }
        .ignoresSafeArea()
        .toolbar {
            // Кнопка "Назад" (или "Закрыть")
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss() 
                } label: {
                    HStack(spacing: 4) {
                        Image(systemName: "chevron.left")
                        Text("Назад") // Можно заменить на "Закрыть"
                    }
                }
            }
        }
        }
    }
    
    private var formContent: some View {
        VStack(spacing: 32) {
                emailInputField
                passwordInputField
        }
        .padding(16)
    }
    
    private var errorMessage: some View {
        Text(viewModel.errorMessage ?? "")
            .foregroundStyle(.red)
            .padding(.horizontal, 16)
    }
    
    private var emailInputField: some View {
        KraevedTextInput(value: $viewModel.email, title: "common.email", placeholder: "login.enterEmail", keyboardType: .emailAddress)
            .onChange(of: viewModel.email) {
                // handleEmailChange()
            }
            .font(.system(size: 18))
    }
    
    private var passwordInputField: some View {
        VStack(alignment: .leading) {
            Text("common.password")
                .font(.system(size: 12))
                .foregroundStyle(Color.Kraeved.Gray.darkest)
            SecureField("common.password", text: $viewModel.password)
                .padding( .init(top: 16, leading: 16, bottom: 16, trailing: 16))
                .background(Color.Kraeved.Gray.lighten)
                .cornerRadius(14)
        }
    }
    
    
    private var buttons: some View {
        VStack {
            KraevedButton(title: "login.submit") {
                handleLoginButtonTap()
            }
            .buttonStyle(.automatic)
            KraevedButton(title: "login.registration") {
                handleRegisterButtonTap()
            }
            .buttonStyle(.automatic)
        }
    }
    
    private func handleLoginButtonTap() {
        Task {
            if await viewModel.login() {
                dismiss()
            }
        }
    }
    
    private func handleRegisterButtonTap() {
        viewModel.register()
    }

}

#Preview {
    LoginEmailPageView()
}
