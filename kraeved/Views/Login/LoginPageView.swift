//
//  LoginPageView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.06.2024.
//

import SwiftUI

// MARK: - LoginPageView
struct LoginPageView: View {
    
    // MARK: - FocusedField
    enum FocusedField {
        case phone, code
    }
    
    // MARK: - Properties
    @ObservedObject private var viewModel = ViewModel()
    @FocusState private var focusedField: FocusedField?
    @Environment(\.dismiss) var dismiss
    @State var showingAlert: Bool = false
    
    private let phoneLimit: Int = 18
    private let codeSize: Int = 4
    
    var buttonDisabled: Bool {
        switch viewModel.stage {
            case .phone:
                return viewModel.phone.count != phoneLimit
            case .code:
                return viewModel.code.count == codeSize
        }
    }
    
    var onDismiss: (() -> Void)?
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.white
            VStack {
                formContent
                errorMessage
                actionButtons
            }
            .frame(height: 290, alignment: .top)
            .disabled(viewModel.isLoading)
            ProgressView()
                .controlSize(.large)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .isVisible(isVisible: viewModel.isLoading)
        }
        .alert("profile.successfulLogin", isPresented: $showingAlert) {
            Button("common.return", role: .cancel) {
                dismiss()
            }
        }
        .ignoresSafeArea()
    }
    
    // MARK: - Private Views
    private var formContent: some View {
        VStack {
            if viewModel.stage == .phone {
                phoneInputField
            }
            if viewModel.stage == .code {
                codeInputField
            }
        }
        .padding(16)
    }
    
    private var errorMessage: some View {
        Text(viewModel.errorMessage ?? "")
            .foregroundStyle(.red)
            .padding(.horizontal, 16)
    }
    
    private var phoneInputField: some View {
        KraevedTextInput(value: $viewModel.phone, title: "common.phone", placeholder: PhoneFormatter.phonePrefix, keyboardType: .phonePad)
            .onChange(of: viewModel.phone) {
                handlePhoneChange()
            }
            .font(.system(size: 18))
            .focused($focusedField, equals: .phone)
    }
    
    private var codeInputField: some View {
        KraevedTextInput(value: $viewModel.code, title: "common.code", placeholder: "", keyboardType: .phonePad)
            .onChange(of: viewModel.code) {
                handleCodeChange()
            }
            .font(.system(size: 18))
            .focused($focusedField, equals: .code)
    }
    
    private var actionButtons: some View {
        VStack {
            KraevedButton(title: viewModel.stage == .phone ? "common.send" : "common.back") {
                handleActionButtonTap()
            }
            .disabled(buttonDisabled)
            .buttonStyle(.automatic)
        }
    }
    
    // MARK: - Private Methods
    private func handlePhoneChange() {
        viewModel.phone = PhoneFormatter.format(phoneNumber: viewModel.phone)
    }
    
    private func handleCodeChange() {
        viewModel.code = String(viewModel.code.prefix(codeSize))
        if viewModel.code.count == codeSize {
            Task {
                if await viewModel.sendCode() {
                    showingAlert = true
                }
            }
        }
        if viewModel.code.count > 0 && !(viewModel.errorMessage?.isEmpty ?? true) {
            viewModel.errorMessage = ""
        }
    }
    
    private func handleActionButtonTap() {
        Task {
            switch viewModel.stage {
                case .phone:
                    await viewModel.sendPhone()
                case .code:
                    // Назад к вводу номера
                    viewModel.stage = .phone
                    focusedField = .phone
            }
        }
    }
}

// MARK: - Preview
#Preview {
    LoginPageView()
}
