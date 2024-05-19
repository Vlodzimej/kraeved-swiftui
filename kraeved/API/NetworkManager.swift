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
    func get<T: Decodable>(url: String, parameters: Parameters?) async -> T?
    func post(url: String, parameters: Parameters) async throws -> Void
    func upload(images: [UIImage]) async throws -> [String]
}

//MARK: - NetworkManager
final class NetworkManager: NSObject, ObservableObject, NetworkManagerProtocol {
    static let shared = NetworkManager()
    
    @Published var isLoading = false
    @Published var isFailed = false
    
    func get<T: Decodable>(url: String, parameters: Parameters?) async -> T? {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(
                    Settings.instance.baseUrl + "/" + url,
                    parameters: parameters
                    //headers: commonHeaders,
                    //requestModifier: { $0.timeoutInterval = self.maxWaitTime }
                )
                .responseData { response in
                    switch response.result {
                        case let .success(data):
                            var result: KraevedResponse<T>? = nil
                            do {
                                result = try Self.parseData(data: data)
                            }
                            catch let error as NSError {
                                var userInfo = error.userInfo
                                userInfo["url"] = url
                                userInfo["code"] = error.code
                                
                                self.log(label: error.localizedDescription, level: .error, message: "", userInfo: userInfo)
                            }
                            continuation.resume(returning: result?.data)
                        case .failure:
                            continuation.resume(returning: nil)
                    }
                }
            }
        }
        catch {
            return nil
        }
    }
    
    func post(url: String, parameters: Parameters) async throws -> Void {
        do {
            return try await withCheckedThrowingContinuation { continuation in
                AF.request(
                    Settings.instance.baseUrl + "/" + url,
                    method: .post,
                    parameters: parameters,
                    encoding: JSONEncoding.default
                )
                .responseData { response in
                    switch response.result {
                        case let .success(data):
                            continuation.resume()
                        case .failure(let error):
                            print(error)
                            continuation.resume(throwing: error)
                    }
                }
            }
        }
    }
    
    func upload(images: [UIImage]) async throws -> [String] {
        guard let url = URL(string: Settings.instance.baseUrl + "/" + "images") else { return [] }
        do {
            return try await withCheckedThrowingContinuation { continuation in
                AF.upload(
                    multipartFormData: { multipartFormData in
                        images.enumerated().forEach { index, image in
                            if let imageData = image.jpegData(compressionQuality: 0.8) {
                                multipartFormData.append(imageData, withName: "imageFiles", fileName: "image\(index).jpg", mimeType: "image/jpeg")
                            }
                        }
                    },
                    to: url,
                    method: .post, headers: nil)
                    .uploadProgress(queue: .main) { progress in
                        print("UPLOADING PROGRESS", progress)
                    }
                    .responseJSON { response in
                        switch response.result {
                            case .success(let jsonData):
                                if let responseData = jsonData as? NSDictionary, let data = responseData["data"] as? NSDictionary, let filenames = data["filenames"] as? [String] {
                                    continuation.resume(returning: filenames)
                                } else {
                                    continuation.resume(returning: [])
                                }
                            case .failure(let error):
                                debugPrint(error)
                                continuation.resume(throwing: error)
                        }
                    }
                
            }
        }
    }
    
    private static func parseData<T: Decodable>(data: Data) throws -> T{
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data)
        else {
            throw NSError(
                domain: "NetworkAPIError",
                code: 3,
                userInfo: [NSLocalizedDescriptionKey: "JSON decode error"]
            )
        }
        return decodedData
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
