//
//  DateFormatter.swift
//  kraeved
//
//  Created by Владимир Амелькин on 30.06.2024.
//

import Foundation

struct CustomDateFormatter {
    static func formatToString(date: Date?, dateFormat: String = Constants.Date.format) -> String? {
        guard let date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.string(from: date)
    }
}
