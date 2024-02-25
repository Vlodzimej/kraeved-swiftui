//
//  UIColor.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI

extension Color {
    init(hex: String, alpha: Double = 1) {
        var hexColor: String
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            hexColor = String(hex[start...])
        } else {
            hexColor = hex
        }
        
        let scanner = Scanner(string: hexColor)
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
    
    struct Kraeved {
        static let mainBackground      = Color(hex: ColorConstants.mainBackground)
        static let secondBackground    = Color(hex: ColorConstants.secondBackground)
        static let cellBackground      = Color(hex: ColorConstants.cellBackground)
        static let cellTextBackground  = Color(hex: ColorConstants.cellTextBackground, alpha: 0.85)
        static let cellTitleFont       = Color(hex: ColorConstants.cellTitleFont)
        static let titleFontMain       = Color(hex: ColorConstants.titleFontMain)
        static let searchFont          = Color(hex: ColorConstants.searchFont)
        static let mainStroke          = Color(hex: ColorConstants.mainStroke)
        static let buttonText          = Color(hex: ColorConstants.buttonText)
        static let divider             = Color(hex: ColorConstants.divider)
        static let highlightedText     = Color(hex: ColorConstants.highlightedText)
    }

}
