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
            case .description: "geo-object-tab-description"
            case .gallery: "geo-object-tab-gallery"
            case .comments: "geo-object-tab-comments"
            case .edit: "geo-object-tab-edit"
        }
        
        return String(localized: resource)
    }
}
