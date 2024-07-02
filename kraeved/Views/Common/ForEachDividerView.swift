//
//  ForEachDividerView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 02.07.2024.
//

// https://stackoverflow.com/questions/72597337/swiftui-automatically-add-dividers-between-each-element-of-a-foreach

import SwiftUI

struct ForEachDividerView<Data, Content, ID>: View where Data: RandomAccessCollection, ID: Hashable, Content: View {
    var data: Data
    var id: KeyPath<Data.Element, ID>
    var color: Color = .gray
    var content: (Data.Element) -> Content

    var body: some View {
        let enumerated = Array(zip(data.indices, data))

        /// first create a `AnyKeyPath` that extracts the element from `enumerated`
        let elementKeyPath: AnyKeyPath = \(Data.Index, Data.Element).1

        /// then, append the `id` key path to `elementKeyPath` to extract the `Hashable` property
        if let fullKeyPath = elementKeyPath.appending(path: id) as? KeyPath<(Data.Index, Data.Element), ID> {
            ForEach(enumerated, id: fullKeyPath) { index, data in

                content(data)

                if let index = index as? Int, index != enumerated.count - 1 {
                    Divider()
                        .background(color)
                }
            }
        }
    }
}
