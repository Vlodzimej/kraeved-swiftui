//
//  GeoObjectView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 04.02.2024.
//

import SwiftUI

//MARK: - KraevedPage
struct KraevedPage: Identifiable {
    var id = UUID()
    let title: String
    var isSelected: Bool = false
}

//MARK: - GeoObjectView
struct GeoObjectView: View {
    
    //MARK: Properties
    let id: Int?
    @ObservedObject private var viewModel = ViewModel()
    @State var selectedTab = 0
    
    private let pages: [KraevedPage] = [
        .init(title: "Инфо", isSelected: true),
        .init(title: "Фото"),
        .init(title: "Отзывы")
    ]
    
    @State private var pageIndex: Int = 0
    
    var body: some View {
        ZStack {
            Color.Kraeved.secondBackground
            VStack(spacing: 0) {
                Text(viewModel.geoObject?.name ?? "")
                    .font(.system(size: 14))
                Divider()
                    .overlay(Color.Kraeved.divider)
                    .padding(.bottom, 16)
                    .padding(.top, 4)
                HStack {
                    ForEach(pages) { item in
                        GeoObjectButtonView(title: item.title, action: {
                            guard let index = self.pages.firstIndex(where: { $0.id == item.id }) else { return }
                            self.selectedTab = index
                            print(index)
                        })
                    }
                }
                
                TabView(selection: $selectedTab) {
                    GeoObjectInfoDescription(description: viewModel.geoObject?.description ?? "")
                        .tag(0)
                    GeoObjectInfoGallery(imageUrls: viewModel.geoObject?.imageUrls ?? [])
                        .tag(1)
                    GeoObjectInfoComments()
                        .tag(2)
                }
                .tabViewStyle(.page)
                .padding(.top, 16)
            }
            .padding(.top, 52)
            .padding(.bottom, 32)
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea()
        .task {
            guard let id else { return }
            await viewModel.getGeoObject(id: id)
        }
    }
}

#Preview {
    GeoObjectView(id: 0)
}
