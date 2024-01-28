//
//  Network.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI
import Pulse
import Alamofire

protocol NetworkManagerProtocol: ApplicationLoggerProtocol {
    func get(url: String, parameters: Parameters?) async throws -> Data 
}

//MARK: - NetworkManager
final class NetworkManager: NSObject, ObservableObject, NetworkManagerProtocol {
    
    static let shared = NetworkManager()
    
    @Published var isLoading = false
    @Published var isFailed = false
    
    func get(url: String, parameters: Parameters?) async throws -> Data {
       // You must resume the continuation exactly once
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(
                Settings.instance.baseUrl + "/" + url,
                parameters: parameters
                //headers: commonHeaders,
                //requestModifier: { $0.timeoutInterval = self.maxWaitTime }
            )
            .responseData { response in
                switch(response.result) {
                case let .success(data):
                    continuation.resume(returning: data)
                case let .failure(error):
                    continuation.resume(throwing: self.handleError(error: error))
                }
            }
        }
    }
    
    private func handleError(error: AFError) -> Error {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost
            {
                var userInfo = nserror.userInfo
                userInfo[NSLocalizedDescriptionKey] = "Unable to connect to the server"
                let currentError = NSError(
                    domain: nserror.domain,
                    code: code,
                    userInfo: userInfo
                )
                return currentError
            }
        }
        return error
    }
}


extension NetworkManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
