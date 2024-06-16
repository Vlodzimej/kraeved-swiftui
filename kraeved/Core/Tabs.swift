//
//  Tabs.swift
//  kraeved
//
//  Created by Владимир Амелькин on 08.02.2024.
//

import SwiftUI

//MARK: - KraevedTabType
enum KraevedTabType: String {
    
    //MARK: GeoObjectDetails
    case description, gallery, comments, edit
    
    var title: String {
        let resource: LocalizedStringResource = switch self {
            //MARK: GeoObjectDetails
            case .description:  "geoObject.tabDescription"
            case .gallery:      "geoObject.tabGallery"
            case .comments:     "geoObject.tabComments"
            case .edit:         "geoObject.tabEdit"
        }
        
        return String(localized: resource)
    }
}
