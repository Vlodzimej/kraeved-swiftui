//
//  GeoObjectDetailsView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 04.02.2024.
//

import SwiftUI

//MARK: - GeoObjectDetailsView
struct GeoObjectDetailsView: View {
    
    //MARK: Properties
    @ObservedObject private var viewModel = ViewModel()
    
    @State private var isEditFormPresented = false
    
    
    let id: Int?
    
    let removeAction: (Int) -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text(viewModel.geoObject?.name ?? "")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.Kraeved.darkGrey)
                Divider()
                    .overlay(Color.Kraeved.divider)
                    .padding(.bottom, 16)
                    .padding(.top, 4)
                GeoObjectDetailsTabView(geoObject: viewModel.geoObject, removeAction: removeAction)

            }
            .padding(.bottom, 32)
            .padding(.horizontal, 16)
            .isVisible(isVisible: !viewModel.isLoading)
            ProgressView()
                .controlSize(.large)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .isVisible(isVisible: viewModel.isLoading)
        }
        .background(.clear)
        .task {
            guard let id else { return }
            await viewModel.getGeoObject(id: id)
        }
        .fullScreenCover(isPresented: $isEditFormPresented) {
            GeoObjectFormView(
                initialGeoObject: viewModel.geoObject,
                mode: .edit
            )
        }
    }
}
