//
//  Network.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI

protocol APIManagerProtocol: AnyObject {
    func getGeoObjects(name: String, regionId: Int) async
}

enum APIError: Error {
    case badRequest
}

class APIManager: NSObject, APIManagerProtocol, ObservableObject {
    static let shared = APIManager()
    
    @Published var geoObjects: [GeoObjectBrief] = []
    @Published var mapGeoObjects: [GeoObjectBrief] = []
    
    func getGeoObjects(name: String = "", regionId: Int) async {
        let result: [GeoObjectBrief]? = await get(urlString: "https://192.168.1.4:5001/api/geoObjects?name=\(name)&regionId=\(regionId)")
        guard let result else { return }
        
        await MainActor.run {
            geoObjects = result
        }
    }
    
    private func get<DataType: Decodable>(urlString: String) async -> DataType? {
        guard let url = URL(string: urlString) else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        do {
            let (data, response) = try await session.data(for: urlRequest)
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw APIError.badRequest
            }
            
            let decodedObject = try JSONDecoder().decode(KraevedResponse<DataType>.self, from: data)
            return decodedObject.data
        } catch let error {
            print("Error decoding: ", error)
        }
        
        return nil
    }
}

extension APIManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
