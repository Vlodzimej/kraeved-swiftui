//
//  LoginPageViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.06.2024.
//

import Foundation

//MARK: - LoginPageView
extension LoginPageView {
    
    //MARK: - ViewModel
    final class ViewModel: BaseViewModel {
        
        //MARK: LoginStage
        enum LoginStage {
            case phone, code
        }
        
        @Published var phone: String = ""
        @Published var code: String = ""
        
        @Published var stage: LoginStage = .phone
        
        //MARK: Public Methods
        func sendPhone() async {
            stage = .code
        }
        
        func sendCode() async {
            
        }
    }
}
