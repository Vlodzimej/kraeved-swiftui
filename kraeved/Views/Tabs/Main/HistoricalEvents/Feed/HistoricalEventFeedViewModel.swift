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
            let result = await kraevedAPI.getHistoricalEvents()
            if case let .success(historicalEvents) = result {
                self.historicalEvents = historicalEvents
            }
        }
    }
}
