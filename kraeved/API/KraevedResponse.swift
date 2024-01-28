//
//  NetworkResponse.swift
//  kraeved
//
//  Created by Владимир Амелькин on 29.09.2023.
//

import Foundation

//MARK: - NetworkResponse
struct KraevedResponse<DataType: Decodable>: Decodable {
    let requestUrl: String
    let data: DataType
    let statusCode: Int
}
