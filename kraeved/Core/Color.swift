//
//  UIColor.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI

extension Color {
    init(hex: String, alpha: Double = 1) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, opacity: alpha
        )
    }
    
    static let mainBackground: Color = Color(hex: "FFFEF7")
    static let cellBackground: Color = Color(hex: "F4F2E5")
    static let cellTextBackground: Color = Color(hex: "ECEADD", alpha: 0.85)
    static let cellTitleFont: Color = Color(hex: "242424")
    
    static let titleFontMain: Color = Color(hex: "1A8F8F")

}
