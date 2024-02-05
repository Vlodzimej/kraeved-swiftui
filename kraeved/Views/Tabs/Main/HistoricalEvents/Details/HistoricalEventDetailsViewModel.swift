//
//  HistoricalEventDetailsViewModel.swift
//  kraeved
//
//  Created by Владимир Амелькин on 31.01.2024.
//

import SwiftUI

//MARK: - HistoricalEventDetailsView
extension HistoricalEventDetailsView {
    
    final class ViewModel: BaseViewModel {
        
        @Published private(set) var historicalEvent: HistoricalEvent?
        
        func getHistoricalEvent(id: Int) async {
            guard historicalEvent == nil else { return }
            Task {
                historicalEvent = await kraevedAPI.getHistoricalEvent(id: id)
            }
        }
        
    }
}
