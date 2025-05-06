//
//  UserInDto.swift
//  kraeved
//
//  Created by Владимир Амелькин on 06.05.2025.
//

import Foundation

struct UserInDto: Decodable {
    
    let id: Int
    let phone: String
    let email: String
    let name: String?
    let surname: String?
    let startDate: String
    
    init(id: Int, phone: String, email: String, name: String?, surname: String?, startDate: String) {
        self.id = id
        self.phone = phone
        self.email = email
        self.name = name
        self.surname = surname
        self.startDate = startDate
    }
}
