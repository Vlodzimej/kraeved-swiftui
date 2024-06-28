//
//  PhoneFormatter.swift
//  kraeved
//
//  Created by Владимир Амелькин on 28.06.2024.
//

//https://stackoverflow.com/questions/32364055/formatting-phone-number-in-swift

import Foundation

final class PhoneFormatter {
    
    static let phonePrefix: String = "+7"
    
    static func format(phoneNumber: String, shouldRemoveLastDigit: Bool = false) -> String {
        guard !phoneNumber.isEmpty else { return "" }

        var number = prepare(phoneNumber: phoneNumber)
        
        if number.count > 10 {
            let tenthDigitIndex = number.index(number.startIndex, offsetBy: 10)
            number = String(number[number.startIndex..<tenthDigitIndex])
        }

        if shouldRemoveLastDigit {
            let end = number.index(number.startIndex, offsetBy: number.count-1)
            number = String(number[number.startIndex..<end])
        }

        if number.count < 7 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d+)", with: "($1) $2", options: .regularExpression, range: range)
            
        } else if number.count < 9 {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: range)
        } else {
            let end = number.index(number.startIndex, offsetBy: number.count)
            let range = number.startIndex..<end
            number = number.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d{2})(\\d+)", with: "($1) $2-$3-$4", options: .regularExpression, range: range)
        }

        return number.count > 0 ? "\(phonePrefix) \(number)" : ""
    }
    
    static func prepare(phoneNumber: String) -> String {
        guard let regex = try? NSRegularExpression(pattern: "[\\s-\\(\\)]", options: .caseInsensitive) else { return "" }
        
        let r = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: .init(rawValue: 0), range: r, withTemplate: "")
        
        if let prefixRange = number.ranges(of: phonePrefix).first {
            number.replaceSubrange(prefixRange, with: "")
        }
        
        return number
    }
}
