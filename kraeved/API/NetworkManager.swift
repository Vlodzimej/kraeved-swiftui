//
//  Network.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

protocol NetworkManagerProtocol: AnyObject {

}

enum KraevedError: Error {
    case wrongUrl
    case badRequest
}

class NetworkManager: NSObject, NetworkManagerProtocol, ObservableObject {
    @Published var isLoading = false
    
    func fetch<T: Decodable>(urlString: String) async -> Result<T, Error> {
        await MainActor.run {
            isLoading = true
        }
        
        do {
            guard let url = URL(string: Constants.baseUrl + "/" + urlString) else {
                throw KraevedError.wrongUrl
            }
            let urlRequest = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
            let (data, response) = try await session.data(for: urlRequest)
            
            await MainActor.run {
                isLoading = false
            }
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw KraevedError.badRequest
            }
            
            let decodedObject = try JSONDecoder().decode(KraevedResponse<T>.self, from: data)

            return .success(decodedObject.data)
        } catch let error {
            #if DEBUG
                debugPrint("Error: ", error)
            #endif
            
            return .failure(error)

        }
        
        await MainActor.run {
            isLoading = false
        }
    }
}

extension NetworkManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
