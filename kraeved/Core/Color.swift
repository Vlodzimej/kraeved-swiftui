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
        static let mainBackground      = Color.white
        static let secondBackground    = Color.Pallete.mintCream
        static let cellBackground      = Color.Pallete.azure
        static let cellTextBackground  = Color(hex: ColorConstants.cellTextBackground, alpha: 0.85)
        static let cellTitleFont       = Color.Pallete.viridian
        static let titleFontMain       = Color.Pallete.viridian
        static let searchFont          = Color.Pallete.cambridgeBlue
        static let mainStroke          = Color.Pallete.cambridgeBlue
        static let buttonText          = Color.Pallete.viridian
        static let divider             = Color.Pallete.mintGreen
        static let highlightedText     = Color.Pallete.cambridgeBlue
        
        struct Gray {
            static let darkest     = Color(hex: ColorConstants.darkGrey)
            static let dark        = Color(hex: "#595959")
            static let middle      = Color(hex: "#7F7F7F")
            static let silver      = Color(hex: "#A5A5A5")
            static let silverLight = Color(hex: "#CCCCCC")
            static let light       = Color(hex: "#F2F2F2")
            static let lighten     = Color(hex: ColorConstants.lightGrey)
        }
    }
    
    struct Pallete {
        static let viridian      = Color(hex: "#6b9080")
        static let cambridgeBlue = Color(hex: "#A4C3B2")
        static let mintGreen     = Color(hex: "#CCE3DE")
        static let azure         = Color(hex: "#EAF4F4")
        static let mintCream     = Color(hex: "#F6FFF8")
    }
    
    

}
