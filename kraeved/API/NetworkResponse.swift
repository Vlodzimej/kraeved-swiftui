//
//  NetworkResponse.swift
//  kraeved
//
//  Created by Владимир Амелькин on 29.09.2023.
//

import Foundation

//MARK: - NetworkResponse
struct NetworkResponse<DataType: Decodable>: Decodable {
    let requestUrl: String
    let data: DataType
    let error: String?
    let status: Bool
    let statusCode: Int
}
