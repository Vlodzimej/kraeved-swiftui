//
//  UploadImageState.swift
//  kraeved
//
//  Created by Владимир Амелькин on 19.05.2024.
//

import SwiftUI

enum UploadImageState {
    case empty, loading(Progress), success(Image), failure(Error)
}
