//
//  Network.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

//MARK: - NetworkManager
final class NetworkManager: NSObject, ObservableObject {
    
    static let shared = NetworkManager()
    
    @Published var isLoading = false
    @Published var isFailed = false
    
    func getGeoObjects(regionId: Int = Constants.defaultRegion, name: String = "") async -> Result<[GeoObjectBrief], Error> {
        await fetch(urlString: "GeoObjects?regionId=\(regionId)")
    }
    
    func getHistoricalEvents(regionId: Int = Constants.defaultRegion, name: String = "") async -> Result<[HistoricalEventBrief], Error> {
        await fetch(urlString: "HistoricalEvents?name=\(name)&regionId=\(regionId)>")
    }
    
    func getGeoObject(id: Int) async ->  Result<GeoObject, Error> {
        await fetch(urlString: "GeoObjects/\(id)")
    }
    
    private func fetch<T: Decodable>(urlString: String) async -> Result<T, Error> {
        await MainActor.run {
            isLoading = true
        }
        
        do {
            guard let url = URL(string: Settings.instance.baseUrl + "/" + urlString) else {
                throw NetworkError.wrongUrl
            }
            print("URL CHECK", url.absoluteString)
            let urlRequest = URLRequest(url: url)
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
            let (data, response) = try await session.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw NetworkError.badRequest
            }
            
            let decodedObject = try JSONDecoder().decode(NetworkResponse<T>.self, from: data)
            
            await MainActor.run {
                isLoading = false
            }
            return .success(decodedObject.data)
        } catch let error {
#if DEBUG
            debugPrint("CHECK Error: ", error.localizedDescription)
#endif
            
            await MainActor.run {
                isLoading = false
                isFailed = true
            }

            return .failure(error)
        }
    }
}

extension NetworkManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
