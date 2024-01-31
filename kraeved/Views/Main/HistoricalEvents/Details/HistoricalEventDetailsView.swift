//
//  HistoricalEventDetailsView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 31.01.2024.
//

import SwiftUI

//MARK: - HistoricalEventDetailsView
struct HistoricalEventDetailsView: View {
    
    //MARK: Properties
    let id: Int?
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text(viewModel.historicalEvent?.name ?? "")
                    .font(.title)
                Spacer()
                Text(viewModel.historicalEvent?.description ?? "")
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
            }
            .padding()
            .task {
                guard let id else { return }
                await viewModel.getHistoricalEvent(id: id)
            }
        }
    }
}
