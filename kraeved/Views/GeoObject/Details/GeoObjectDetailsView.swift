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
                    VStack(alignment: .center) {
                        Text(viewModel.geoObject?.name ?? "")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.Kraeved.Gray.darkest)
                    }
                    .padding(.init(top: 8, leading: 16, bottom: 0, trailing: 16))
                    VStack {
                        Text(viewModel.geoObject?.description ?? "")
                            .font(.system(size: 14))
                            .foregroundStyle(Color.Kraeved.Gray.dark)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.init(top: 4, leading: 16, bottom: 16, trailing: 16))
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
