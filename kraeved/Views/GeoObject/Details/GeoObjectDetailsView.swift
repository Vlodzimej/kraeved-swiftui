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

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Text(viewModel.geoObject?.name ?? "")
                    .font(.system(size: 14))
                Divider()
                    .overlay(Color.Kraeved.divider)
                    .padding(.bottom, 16)
                    .padding(.top, 4)
                GeoObjectDetailsTabView(geoObject: viewModel.geoObject)

            }
            .padding(.bottom, 32)
            .padding(.horizontal, 16)
        }
        .background(.clear)
        .task {
            guard let id else { return }
            await viewModel.getGeoObject(id: id)
        }
        .fullScreenCover(isPresented: $isEditFormPresented) {
            GeoObjectFormView(
                mode: .edit,
                name: viewModel.geoObject?.name,
                typeId: viewModel.geoObject?.type?.id,
                description: viewModel.geoObject?.description,
                thumbnail: viewModel.geoObject?.thumbnail,
                images: viewModel.geoObject?.images,
                latitude: String(viewModel.geoObject?.latitude ?? 0),
                longitude: String(viewModel.geoObject?.longitude ?? 0),
                isShowForm: $isEditFormPresented
            )
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Menu(content: {
                    Button {
                        isEditFormPresented = true
                    } label: {
                        Label("edit", systemImage: "square.and.pencil")
                    }
                    
                    Button {
                        print("test")
                    } label: {
                        Label("delete", systemImage: "trash")
                    }
                }) {
                    Image(systemName: "ellipsis.circle")
                }
            }
        }
    }
}

#Preview {
    GeoObjectDetailsView(id: 0)
}
