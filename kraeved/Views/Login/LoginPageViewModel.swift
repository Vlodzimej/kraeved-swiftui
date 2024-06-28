import Foundation
import Combine

// MARK: - LoginPageView
extension LoginPageView {
    
    // MARK: - ViewModel
    final class ViewModel: BaseViewModel {
        
        // MARK: - LoginStage
        enum LoginStage {
            case phone, code
        }
        
        // MARK: - Properties
        @Published var phone: String = ""
        @Published var code: String = ""
        @Published var stage: LoginStage = .phone {
            didSet {
                errorMessage = nil
                code = ""
            }
        }
        
        private var cancellables = Set<AnyCancellable>()
        private var preparedPhone: String {
            PhoneFormatter.prepare(phoneNumber: phone)
        }
        
        private var password: String = ""
        
        // MARK: - Public Methods
        func sendPhone() async {
            isLoading = true
            defer { isLoading = false }
            
            let result = await kraevedAPI.sendPhone(phone: preparedPhone)
            switch result {
                case .success(let status):
                    stage = .code
                case .failure(let error):
                    errorMessage = error.localizedDescription
            }
        }
        
        func sendCode() async {
            isLoading = true
            defer { isLoading = false }
            
            let result = await kraevedAPI.sendCode(phone: preparedPhone, code: code)
            switch result {
                case .success(let loginDto):
                    password = loginDto.password ?? ""
                case .failure(let error):
                    errorMessage = error.localizedDescription
            }
            
            let loginResult = await kraevedAPI.login(phone: preparedPhone, password: password)
            switch loginResult {
                case .success(let loginDto):
                    print("CHECK", loginDto.token ?? "")
                case .failure(let error):
                    errorMessage = error.localizedDescription
            }
        }
    }
}
