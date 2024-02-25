//
//  TabItem.swift
//  kraeved
//
//  Created by Владимир Амелькин on 08.02.2024.
//

import SwiftUI

//MARK: - KraevedTabItem
struct KraevedTabItem: Identifiable, Hashable {
    var id = UUID()
    var index: Int
    let type: KraevedTabType
}

protocol KraevedTabItemProtocol {
    var title: String { get }
    var view: any View { get }
}
