//
//  LoginPageView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.06.2024.
//

import SwiftUI

// MARK: - LoginPageView
struct LoginPageView: View {
    
    // MARK: FocusedField
    enum FocusedField {
        case phone, code
    }
    
    // MARK: Properties
    @ObservedObject private var viewModel = ViewModel()
    @FocusState private var focusedField: FocusedField?
    
    private let phoneLimit: Int = 18
    private let codeLimit: Int = 4
    
    var buttonDisabled: Bool {
        switch viewModel.stage {
            case .phone:
                return viewModel.phone.count != phoneLimit
            case .code:
                return viewModel.code.count != codeLimit
        }
    }
    
    var onDismiss: (() -> Void)?
    
    // MARK: Body
    var body: some View {
        ZStack {
            Color.Kraeved.cellBackground
            VStack {
                formContent
                errorMessage
                actionButtons
            }
            .frame(height: 290, alignment: .center)
            .disabled(viewModel.isLoading)
            ProgressView()
                .controlSize(.large)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .isVisible(isVisible: viewModel.isLoading)
        }
        .ignoresSafeArea()
    }
    
    // MARK: - Private Views
    private var formContent: some View {
        Form {
            Section {
                if viewModel.stage == .phone {
                    phoneInputField
                }
                if viewModel.stage == .code {
                    codeInputField
                }
            }
        }
        .scrollDisabled(true)
        .modifier(FormHiddenBackground())
    }
    
    private var errorMessage: some View {
        Text(viewModel.errorMessage ?? "")
            .foregroundStyle(.red)
    }
    
    private var phoneInputField: some View {
        GenericTextInput(value: $viewModel.phone, title: "common.phone", placeholder: PhoneFormatter.phonePrefix, keyboardType: .phonePad, tracking: 1.0)
            .onChange(of: viewModel.phone) {
                handlePhoneChange()
            }
            .font(.system(size: 18))
            .focused($focusedField, equals: .phone)
    }
    
    private var codeInputField: some View {
        GenericTextInput(value: $viewModel.code, title: "common.code", placeholder: "", keyboardType: .phonePad, tracking: 2.0)
            .onChange(of: viewModel.code) {
                handleCodeChange()
            }
            .font(.system(size: 18))
            .focused($focusedField, equals: .code)
    }
    
    private var actionButtons: some View {
        VStack {
            KraevedButton(title: viewModel.stage == .phone ? "common.send" : "common.entry") {
                handleActionButtonTap()
            }
            .disabled(buttonDisabled)
            
            Button {
                handleBackButtonTap()
            } label: {
                Text("common.back")
            }
            .buttonStyle(.automatic)
            .isVisible(isVisible: viewModel.stage == .code)
        }
    }
    
    // MARK: - Private Methods
    private func handlePhoneChange() {
        viewModel.phone = PhoneFormatter.format(phoneNumber: viewModel.phone)
    }
    
    private func handleCodeChange() {
        viewModel.code = String(viewModel.code.prefix(codeLimit))
    }
    
    private func handleActionButtonTap() {
        Task {
            switch viewModel.stage {
                case .phone:
                    await viewModel.sendPhone()
                case .code:
                    await viewModel.sendCode()
            }
        }
    }
    
    private func handleBackButtonTap() {
        viewModel.stage = .phone
        focusedField = .phone
    }
}

// MARK: - Preview
#Preview {
    LoginPageView()
}
