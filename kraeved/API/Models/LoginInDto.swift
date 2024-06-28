//
//  LoginInDto.swift
//  kraeved
//
//  Created by Владимир Амелькин on 29.06.2024.
//

import Foundation

struct LoginInDto: Decodable {
    
    let password: String?
    let token: String?
}
