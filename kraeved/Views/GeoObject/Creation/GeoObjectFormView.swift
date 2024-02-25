//
//  GeoObjectFormView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 25.02.2024.
//

import SwiftUI

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
    
    @State private var isLoggerPresented = false
    @ObservedObject private var viewModel = ViewModel()
    
    let mode: GeoObjectFormMode
    
    var name: String?
    var typeId: Int?
    var description: String?
    var thumbnailUrl: URL?
    var imageUrls: [URL]?
    
    let latitude: String
    let longitude: String
    @Binding var isShowForm: Bool
    
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
                    Picker("region", selection: $viewModel.regionId) {
                        ForEach(regions) {
                            Text($0.title).tag($0.id)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section {
                    // Title
                    GenericTextInput(
                        value: $viewModel.name,
                        title: String(localized: "title"),
                        placeholder: String(localized: "title-placeholder"),
                        keyboardType: .default
                    )
                    .pickerStyle(.navigationLink)
                    .labelsHidden()
                    
                    // Description
                    GenericTextInput(
                        value: $viewModel.description,
                        title: String(localized: "description"),
                        placeholder: String(localized: "description-placeholder"),
                        keyboardType: .default,
                        symbolsLimit: 3000,
                        axis: .vertical
                    )
                }
                Section {
                    // Thumbnail
                    GenericTextInput(
                        value: $viewModel.thumbnailUrl,
                        title: String(localized: "thumbnail"),
                        placeholder: "",
                        keyboardType: .default,
                        symbolsLimit: 250
                    )
                    .pickerStyle(.navigationLink)
                    .labelsHidden()
                    HStack {
                        Spacer()
                        Button {
                            
                        } label: {
                            Text("viewing")
                                .font(.system(size: 12))
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isShowForm.toggle()
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
                viewModel.submit(latitude: latitude, longitude: longitude)
            }
            KraevedButton(title: "Logger") {
               isLoggerPresented = true
            }
        }
        .task {
            await viewModel.fetchGeoObjectTypes()
        }
        .onAppear {
            configure()
        }
        .alert("Объект создан", isPresented: $viewModel.isShowAlert) {
            Button("close", role: .cancel) {
                isShowForm = false
            }
        }
    }
    
    private func configure() {
        viewModel.mode = mode
        
        if let name {
            viewModel.name = name
        }
        
        if let typeId {
            viewModel.typeId = typeId
        }
        
        if let description {
            viewModel.description = description
        }
        
        if let thumbnailUrl {
            viewModel.thumbnailUrl = thumbnailUrl.absoluteString
        }
        
        if let imageUrls {
            viewModel.imageUrls = imageUrls.map { $0.absoluteString }
        }
    }
}

#Preview {
    @State var isShowCreation: Bool = false
    
    return GeoObjectFormView(mode: .creation, latitude: "", longitude: "", isShowForm: $isShowCreation)
}
