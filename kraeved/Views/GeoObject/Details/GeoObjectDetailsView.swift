//
//  GeoObjectDetailsView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 04.02.2024.
//

import SwiftUI
import CachedAsyncImage

//MARK: - GeoObjectDetailsView
struct GeoObjectDetailsView: View {
    
    //MARK: Properties
    @ObservedObject private var viewModel = ViewModel()
    @State private var isEditFormPresented = false
    
    var images: [GalleryItem] {
        viewModel.geoObject?.imageUrls.enumerated().compactMap({ (index, url) in
            GalleryItem(id: index, url: url)
        }) ?? []
    }
    
    let id: Int?
    let removeAction: (Int) -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ScrollView {
                    if !images.isEmpty {
                        TabView {
                            ForEach(images, id: \.self.id) { item in
                                AsyncImage(url: item.url) { phase in
                                    switch phase {
                                        case .success(let image):
                                            image
                                                .resizable()
                                                .scaledToFill()
                                                .frame(height: geometry.size.width * 0.75)
                                        case .empty:
                                            ProgressView()
                                        case .failure:
                                            EmptyView()
                                        @unknown default:
                                            EmptyView()
                                    }
                                    
                                }
                                .tag(item.id)
                            }
                        }
                        .tabViewStyle(.page)
                        .frame(height: geometry.size.width * 0.75)
                    }
                    
                    Text(viewModel.geoObject?.name ?? "")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(Color.Kraeved.Gray.darkest)
                        .padding(.top, 8)
                        .padding(.bottom, 8)
                }
                .isVisible(isVisible: !viewModel.isLoading)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
}
