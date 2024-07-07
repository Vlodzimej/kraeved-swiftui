//
//  AttractionCellView.swift
//  kraeved
//
//  Created by Владимир Амелькин on 27.09.2023.
//

import SwiftUI
import CachedAsyncImage

//MARK: - AttractionsFeedCellView
struct AttractionsFeedCellView: View {

    //MARK: Properties
    let attractionBrief: GeoObjectBrief
    
    //MARK: Body
    var body: some View {
        ZStack(alignment: .top) {
            Color.white
            VStack(alignment: .center) {
                CachedAsyncImage(url: attractionBrief.thumbnailUrl, urlCache: .imageCache) { state in
                    switch state {
                        case .empty:
                            EmptyThumbnailImageView()
                        case .success(let image):
                            AttractionImageView(imageState: .success(image))
                        case .failure:
                            EmptyThumbnailImageView()
                        @unknown default:
                            EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 250)
                .clipped()
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        titleLabel
                        Spacer()
                        ratingView
                    }
                    descriptionView
                    HStack {
                        locationView
                        Spacer()
                        favoriteView
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
            }
        }
        .redacted(reason: attractionBrief.id == nil ? .placeholder : [])
    }
    
    private var titleLabel: some View {
        Text(attractionBrief.name ?? "")
            .font(.system(size: 16, weight: .semibold))
            .foregroundColor(Color.Kraeved.text)
            .lineLimit(2)
            .multilineTextAlignment(.leading)
            .redacted(reason: attractionBrief.name == nil ? .placeholder : [])
    }
    
    private var ratingView: some View {
        HStack(alignment: .center, spacing: 4) {
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundStyle(Color.yellow)
            Text("5.0")
                .font(.system(size: 12))
        }
    }
    
    private var descriptionView: some View {
        Text(attractionBrief.shortDescription ?? "")
            .font(.system(size: 14))
            .foregroundColor(Color.Kraeved.text)
            .lineLimit(3)
            .multilineTextAlignment(.leading)
    }
    
    private var locationView: some View {
        HStack(spacing: 4) {
            Image("locationMark")
                .renderingMode(.template)
                .foregroundColor(Color.Kraeved.Gray.silver)
            Text("Калуга, Площадь Победы, 1")
                .font(.system(size: 12))
                .foregroundStyle(Color.Kraeved.Gray.middle)
        }
    }
    
    private var favoriteView: some View {
        Image(systemName: "bookmark")
            .foregroundStyle(Color.Kraeved.Gray.silver)
    }
}



#Preview {
    VStack(alignment: .leading, spacing: 16) {
        AttractionsFeedCellView(attractionBrief: .init(id: 0,
                                                       name: "Площадь Победы",
                                                       shortDescription: "В мае 1965 года п",
                                                       type: .theater,
                                                       thumbnailUrl: "https://ambassadorkaluga.com/wp-content/uploads/2018/08/ploshad-pobedy.jpg"))
        AttractionsFeedCellView(attractionBrief: .init(id: 0,
                                                       name: "Площадь Победы",
                                                       shortDescription: "В мае 1965 года площадь Социализма была переименована в площадь Победы. В декабре 1966 года, к 25-летию освобождения Калуги от немецко-фашистских захватчиков, на площади был установлен обелиск, возвышающийся на 30 метров. Вечный огонь Славы был зажжен 9 мая 1970 года. В марте 1973 года на вершине обелиска установили семиметровую статую Родины-матери, держащей в руках серебряную ленту реки Оки и первый искусственный спутник Земли — как символ победы советского народа и в освоении космического пространства. Авторами проекта площади Победы были архитекторы Павел Перминов и Евгений Киреев",
                                                       type: .theater,
                                                       thumbnailUrl: "https://ambassadorkaluga.com/wp-content/uploads/2018/08/ploshad-pobedy.jpg"))
    }
}

