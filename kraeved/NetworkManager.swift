//
//  Network.swift
//  kraeved
//
//  Created by Владимир Амелькин on 22.09.2023.
//

import SwiftUI


class NetworkManager: NSObject, ObservableObject {
    static let shared = NetworkManager()
    
    @Published var geoObject: GeoObject?
    
    func getGeoObject() {
    //async -> Result<GeoObject, Error> {
        guard let url = URL(string: "https://192.168.1.4:5001/api/geoObjects/1") else { fatalError("Missing URL") }
        let urlRequest = URLRequest(url: url)
        
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            
            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedObject = try JSONDecoder().decode(GeoObject.self, from: data)
                        self.geoObject = decodedObject
                    } catch let error {
                        print("Error decoding: ", error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    //    func getUsers() {
    //        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { fatalError("Missing URL") }
    //
    //        let urlRequest = URLRequest(url: url)
    //
    //        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
    //            if let error = error {
    //                print("Request error: ", error)
    //                return
    //            }
    //
    //            guard let response = response as? HTTPURLResponse else { return }
    //
    //            if response.statusCode == 200 {
    //                guard let data = data else { return }
    //                DispatchQueue.main.async {
    //                    do {
    //                        let decodedUsers = try JSONDecoder().decode([GeoObject].self, from: data)
    //                        self.users = decodedUsers
    //                    } catch let error {
    //                        print("Error decoding: ", error)
    //                    }
    //                }
    //            }
    //        }
    //
    //        dataTask.resume()
    //    }
}

extension NetworkManager: URLSessionDelegate {
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
}
