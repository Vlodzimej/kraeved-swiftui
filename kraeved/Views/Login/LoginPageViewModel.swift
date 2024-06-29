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
        
        private let securityManager: SecurityManagerProtocol
        
        init(securityManager: SecurityManagerProtocol = SecurityManager.shared) {
            self.securityManager = securityManager
        }
        
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
        
        func sendCode() async -> Bool {
            var password: String?
            var token: String?
            
            isLoading = true
            defer { isLoading = false }
            
            let result = await kraevedAPI.sendCode(phone: preparedPhone, code: code)
            switch result {
                case .success(let loginDto):
                    password = loginDto.password
                case .failure(let error):
                    errorMessage = error.localizedDescription
                    code = ""
            }
            
            guard let password, securityManager.savePassword(service: Settings.instance.currentEnvironment.rawValue,
                                                             account: preparedPhone,
                                                             password: password) else { return false }
            
            let loginResult = await kraevedAPI.login(phone: preparedPhone, password: password)
            switch loginResult {
                case .success(let loginDto):
                    token = loginDto.token
                case .failure(let error):
                    errorMessage = error.localizedDescription
            }
            
            guard let token, securityManager.saveToken(service: Settings.instance.currentEnvironment.rawValue,
                                            account: preparedPhone,
                                            token: token) else { return false }
            
            UserDefaults.standard.setValue(true, forKey: "isAuth")
            UserDefaults.standard.setValue(preparedPhone, forKey: "userPhone")
            return true
        }
    }
}
