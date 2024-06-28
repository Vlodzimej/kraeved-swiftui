//
//  LoginPageView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.06.2024.
//

import SwiftUI

//MARK: - LoginPageView
struct LoginPageView: View {

    @ObservedObject private var viewModel = ViewModel()
    
    var buttonDisabled: Bool {
        switch viewModel.stage {
            case .phone:
                return viewModel.phone.count != phoneLimit
            case .code:
                return viewModel.code.count != codeLimit
        }
    }
    
    var onDismiss: (() -> Void)? = nil
    
    private let phoneLimit: Int = 12
    private let codeLimit: Int = 6
    private let phonePrefix: String = "+7"
    
    var body: some View {
        ZStack {
            Color.Kraeved.cellBackground
            VStack {
                Form {
                    Section {
                        if viewModel.stage == .phone {
                            GenericTextInput(value: $viewModel.phone, title: "common.phone", placeholder: phonePrefix, keyboardType: .phonePad, tracking: 2.0)
                                .onChange(of: viewModel.phone) {
                                    handleChangePhone()
                                }
                                .font(.system(size: 18))
                        }
                        if viewModel.stage == .code {
                            GenericTextInput(value: $viewModel.code, title: "common.code", placeholder: "", keyboardType: .phonePad, tracking: 2.0)
                                .onChange(of: viewModel.code) {
                                    handleChangeCode()
                                }
                                .font(.system(size: 18))
                        }
                    }
                }
                .modifier(FormHiddenBackground())
                KraevedButton(title: viewModel.stage == .phone ? "common.send" : "common.entry") {
                    switch viewModel.stage {
                        case .phone:
                            Task {
                                await viewModel.sendPhone()
                            }
                        case .code:
                            Task {
                                await viewModel.sendCode()
                                await MainActor.run {
                                    onDismiss?()
                                }
                            }
                    }
                }
                .disabled(buttonDisabled)
            }
            .frame(height: 220, alignment: .center)
        }
        .ignoresSafeArea()
    }
    
    //MARK: Private Methods
    private func handleChangePhone() {
        if !viewModel.phone.contains(phonePrefix) && viewModel.phone.count == 1 {
            viewModel.phone = phonePrefix + viewModel.phone
        } else if viewModel.phone.count <= 2 {
            viewModel.phone = ""
        }
        viewModel.phone = String(viewModel.phone.prefix(phoneLimit))
        phoneButtonDisabled = viewModel.phone.count != 12
    }
    
    private func handleChangeCode() {
        viewModel.code = String(viewModel.code.prefix(codeLimit))
    }
}

#Preview {
    LoginPageView()
}
