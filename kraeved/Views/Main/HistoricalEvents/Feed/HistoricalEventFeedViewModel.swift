//
//  HistoricalEventFeedView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 24.01.2024.
//

import Foundation

extension HistoricalEventFeedView {
    
    //MARK: - ViewModel
    final class ViewModel: BaseViewModel {
                
        //MARK: Properties
        @Published private(set) var historicalEvents: [HistoricalEventBrief]?

        //MARK: Public Methods
        func getHistoricalEvents() async {
            historicalEvents = .init(repeating: .init(), count: 6)
            
            Task {
                historicalEvents = await kraevedAPI.getHistoricalEvents()
            }
        }
    }
}
