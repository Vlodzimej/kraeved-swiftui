//
//  UserOutDto.swift
//  kraeved
//
//  Created by Владимир Амелькин on 30.06.2024.
//

import Foundation

struct UserOutDto {
    
    let name: String?
    let surname: String?
    
    init(name: String? = nil, surname: String? = nil) {
        self.name = name
        self.surname = surname
    }
}
