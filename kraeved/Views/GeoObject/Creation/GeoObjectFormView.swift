//
//  GeoObjectFormView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 25.02.2024.
//

import SwiftUI
import PhotosUI
import Alamofire

let regions: [GenericType] = [
    .init(id: 40, name: "Kalujskaya obl.", title: "Калужская область")
]

enum GeoObjectFormMode {
    case creation, edit
    
    var title: String {
        switch self {
            case .creation:
                return String(localized: "add")
            case .edit:
                return String(localized: "update")
        }
    }
}

//MARK: - GeoObjectFormView
struct GeoObjectFormView: View {
    
    let initialGeoObject: GeoObject?
    
    @Environment(\.dismiss) var dismiss
    
    @State private var isLoggerPresented = false
    @State var selectedItems: [PhotosPickerItem] = []
    
    @ObservedObject private var viewModel = ViewModel()
    @ObservedObject private var thumbnailViewModel = SingleImageUploaderView.ViewModel()
    @ObservedObject private var imagesViewModel = MultipleImageSelectView.ViewModel()
    
    var hasChanges: Bool {
        viewModel.hasChanges || thumbnailViewModel.hasChanges || imagesViewModel.hasChanges
    }
    
    var isRequiredInputsFilled: Bool {
        !viewModel.editedGeoObject.name.isEmpty && !viewModel.editedGeoObject.description.isEmpty
    }
    
    var isThumbnailLoaded: Bool {
        if case .success = thumbnailViewModel.imageState {
            return true
        } else {
            return false
        }
    }
    
    var isFormValidated: Bool {
        switch mode {
            case .creation:
                return isRequiredInputsFilled && isThumbnailLoaded
            case .edit:
                return isRequiredInputsFilled && hasChanges
        }
    }
    
    let mode: GeoObjectFormMode

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // Type
                    Picker("type", selection: $viewModel.typeId) {
                        ForEach(viewModel.types ?? []) {
                            Text($0.title).tag($0.id)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    // Region
                    Picker("region", selection: $viewModel.editedGeoObject.regionId) {
                        ForEach(regions) {
                            Text($0.title).tag($0.id)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section {
                    // Title
                    GenericTextInput(
                        value: $viewModel.editedGeoObject.name,
                        title: String(localized: "title"),
                        placeholder: String(localized: "title-placeholder"),
                        keyboardType: .default
                    )
                    .pickerStyle(.navigationLink)
                    .labelsHidden()
                    
                    // Description
                    GenericTextInput(
                        value: $viewModel.editedGeoObject.description,
                        title: String(localized: "description"),
                        placeholder: String(localized: "description-placeholder"),
                        keyboardType: .default,
                        symbolsLimit: 3000,
                        lineLimit: 20,
                        axis: .vertical
                    )
                }
                Section {
                    // Thumbnail
                    Text("upload-thumbnail-image")
                    VStack {
                        HStack() {
                            Spacer()
                            SingleImageUploaderView(viewModel: thumbnailViewModel)
                            Spacer()
                        }
                    }
                }
                Section {
                    // Gallery
                    Text("upload-gallery")
                    VStack {
                        HStack() {
                            Spacer()
                            MultipleImageSelectView(viewModel: imagesViewModel)
                            Spacer()
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Label("back", systemImage: "chevron.left")
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("add-new-geo-object").font(.headline)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isLoggerPresented) {
                LoggerView()
            }
            
            KraevedButton(title: mode.title) {
                Task {
                    await try viewModel.submit(thumbnailImage: thumbnailViewModel.uploadedImage, images: imagesViewModel.images)
                    dismiss()
                }
            }
            .disabled(!isFormValidated)
        }
        .task {
            await viewModel.fetchGeoObjectTypes()
        }
        .onAppear {
            configure()
        }
        .alert("Объект создан", isPresented: $viewModel.isShowAlert) {
            Button("close", role: .cancel) {
                dismiss()
            }
        }
    }
    
    private func configure() {
        viewModel.mode = mode
        
        if let initialGeoObject {
            viewModel.initialGeoObject = initialGeoObject
            viewModel.editedGeoObject = initialGeoObject
            viewModel.typeId = initialGeoObject.type.id
            
            if let url = initialGeoObject.thumbnailUrl?.absoluteString {
                thumbnailViewModel.fetchImage(by: url)
            }
        
            if !initialGeoObject.imageUrls.isEmpty {
                let urls = initialGeoObject.imageUrls.compactMap{ $0.absoluteString }
                imagesViewModel.fetchImages(by: urls)
            }
        }
    }
    

}
