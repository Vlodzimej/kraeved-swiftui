//
//  User.swift
//  kraeved
//
//  Created by Владимир Амелькин on 30.06.2024.
//

import Foundation

enum UserRole: String, Codable {
    case unknown = "UNKNOWN"
    case admin = "ADMIN"
    case user = "USER"
}

struct User: Codable, Comparable {
    static func < (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id &&
        lhs.phone == rhs.phone &&
        lhs.name == rhs.name &&
        lhs.surname == rhs.surname &&
        lhs.startDate == rhs.startDate &&
        lhs.role == rhs.role
    }
    
    
    let id: Int
    let phone: String
    var name: String
    var surname: String
    let startDate: Date
    let role: UserRole
    
    init(id: Int = 0, phone: String = "", name: String = "", surname: String = "", startDate: Date = Date.now, role: UserRole = .unknown) {
        self.id = id
        self.phone = phone
        self.name = name
        self.surname = surname
        self.startDate = startDate
        self.role = role
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let dateString = try container.decode(String.self, forKey: .startDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.Date.format
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        
        guard let date = dateFormatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .startDate, in: container, debugDescription: "Date string does not match format expected by formatter.")
        }
        
        self.startDate = date
        self.id = try container.decode(Int.self, forKey: .id)
        self.phone = try container.decode(String.self, forKey: .phone)
        self.name = try container.decode(String.self, forKey: .name)
        self.surname = try container.decode(String.self, forKey: .surname)
        self.role = try container.decode(UserRole.self, forKey: .role)
    }
}
