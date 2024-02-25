//
//  UIColor.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import UIKit

extension UIColor {
    public convenience init(hex: String, alpha: Double = 1) {
        let red, green, blue: CGFloat
        
        var hexColor: String
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            hexColor = String(hex[start...])
        } else {
            hexColor = hex
        }
        
        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            blue = CGFloat((hexNumber & 0x0000ff) >> 0) / 255
            
            self.init(red: red, green: green, blue: blue, alpha: alpha)
            return
        }
        
        self.init(red: 255, green: 255, blue: 255, alpha: alpha)
    }
}

extension UIColor {
    struct Kraeved {
        static let mainBackground     = UIColor(hex: ColorConstants.mainBackground)
        static let cellBackground     = UIColor(hex: ColorConstants.cellBackground)
        static let cellTextBackground = UIColor(hex: ColorConstants.cellTextBackground)
        static let cellTitleFont      = UIColor(hex: ColorConstants.cellTitleFont)
        static let titleFontMain      = UIColor(hex: ColorConstants.titleFontMain)
        static let searchFont         = UIColor(hex: ColorConstants.searchFont)
        static let mainStroke         = UIColor(hex: ColorConstants.mainStroke)
    }
}
