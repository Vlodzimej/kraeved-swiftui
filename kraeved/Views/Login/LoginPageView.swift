//
//  LoginPageView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.06.2024.
//

import SwiftUI

//MARK: - LoginPageView
struct LoginPageView: View {

    enum FocusedField {
        case phone, code
    }
    
    @ObservedObject private var viewModel = ViewModel()
    @FocusState private var focusedField: FocusedField?
    
    var buttonDisabled: Bool {
        switch viewModel.stage {
            case .phone:
                return viewModel.phone.count != phoneLimit
            case .code:
                return viewModel.code.count != codeLimit
        }
    }
    
    var onDismiss: (() -> Void)? = nil
    
    private let phoneLimit: Int = 18
    private let codeLimit: Int = 4
    
    var body: some View {
        ZStack {
            Color.Kraeved.cellBackground
            VStack {
                Form {
                    Section {
                        if viewModel.stage == .phone {
                            GenericTextInput(value: $viewModel.phone, title: "common.phone", placeholder: PhoneFormatter.phonePrefix, keyboardType: .phonePad, tracking: 1.0)
                                .onChange(of: viewModel.phone) {
                                    handleChangePhone()
                                }
                                .font(.system(size: 18))
                                .focused($focusedField, equals: .phone)
                            
                        }
                        if viewModel.stage == .code {
                            GenericTextInput(value: $viewModel.code, title: "common.code", placeholder: "", keyboardType: .phonePad, tracking: 2.0)
                                .onChange(of: viewModel.code) {
                                    handleChangeCode()
                                }
                                .font(.system(size: 18))
                                .focused($focusedField, equals: .code)
                        }
                    }
                }
                .scrollDisabled(true)
                .modifier(FormHiddenBackground())
                KraevedButton(title: viewModel.stage == .phone ? "common.send" : "common.entry") {
                    switch viewModel.stage {
                        case .phone:
                            handleSendPhone()
                        case .code:
                            handleSendCode()
                    }
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
            .frame(height: 290, alignment: .center)
        }
        .ignoresSafeArea()
    }
    
    //MARK: Private Methods
    private func handleChangePhone() { 
        viewModel.phone = PhoneFormatter.format(phoneNumber: viewModel.phone)
    }
    
    private func handleChangeCode() {
        viewModel.code = String(viewModel.code.prefix(codeLimit))
    }
    
    private func handleSendPhone() {
        Task {
            await viewModel.sendPhone()
            await MainActor.run {
                focusedField = .code
            }
        }
    }
    
    private func handleSendCode() {
        Task {
            await viewModel.sendCode()
            await MainActor.run {
                onDismiss?()
            }
        }
    }
    
    private func handleBackButtonTap() {
        viewModel.stage = .phone
        focusedField = .phone
    }
}

#Preview {
    LoginPageView()
}
