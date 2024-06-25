//
//  Constants.swift
//  kraeved
//
//  Created by Владимир Амелькин on 24.09.2023.
//

import Foundation
import MapKit

struct Constants {
    static let initialLocation = CLLocationCoordinate2D(latitude: 54.513891, longitude: 36.261191)
    static let defaultRegion: Int = 40
    static let baseUrl: String = "https://127.0.0.4:5001/api"
}

struct ColorConstants {
    static let mainBackground       = "#FFFEF7"
    static let secondBackground     = "#FAFAF4"
    static let cellBackground       = "#F4F2E5"
    static let cellTextBackground   = "#ECEADD"
    static let cellTitleFont        = "#242424"
    static let titleFontMain        = "#1A8F8F"
    static let searchFont           = "#80BAAF"
    static let mainStroke           = "#93C5BB"
    static let buttonText           = "#424242"
    static let divider              = "#4E9494"
    static let highlightedText      = "#DD614B"
    static let darkGrey             = "#202126"
}
