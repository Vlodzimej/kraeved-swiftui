//
//  GeoObjectType.swift
//  kraeved
//
//  Created by Владимир Амелькин on 13.02.2024.
//

import SwiftUI

enum GeoObjectType: String, Decodable, CaseIterable {
	// Историко-культурное наследие (CategoryId = 1)
	case militaryMemorial     = "MILITARY_MEMORIAL"
	case personMonument       = "PERSON_MONUMENT"
	case eventMonument        = "EVENT_MONUMENT"
	case memorialPlaque       = "MEMORIAL_PLAQUE"
	case technicalMonument    = "TECHNICAL_MONUMENT"
	case sculpture            = "SCULPTURE"
	case orthodoxChurch       = "ORTHODOX_CHURCH"
	case monastery            = "MONASTERY"
	case chapel               = "CHAPEL"
	case holySpring           = "HOLY_SPRING"
	case manor                = "MANOR"
	case manorPark            = "MANOR_PARK"
	case historicalBuilding   = "HISTORICAL_BUILDING"
	case merchantHouse        = "MERCHANT_HOUSE"
	case industrialObject     = "INDUSTRIAL_OBJECT"
	case waterTower           = "WATER_TOWER"
	case bridge               = "BRIDGE"
	case railwayStation       = "RAILWAY_STATION"
	
	// Природные объекты (CategoryId = 2)
	case river                = "RIVER"
	case lake                 = "LAKE"
	case pond                 = "POND"
	case spring               = "SPRING"
	case ravine               = "RAVINE"
	case hill                 = "HILL"
	case valley               = "VALLEY"
	case quarry               = "QUARRY"
	case cave                 = "CAVE"
	case oldTree              = "OLD_TREE"
	case grove                = "GROVE"
	case alley                = "ALLEY"
	case park                 = "PARK"
	case nationalPark         = "NATIONAL_PARK"
	case natureReserve        = "NATURE_RESERVE"
	case naturalMonument      = "NATURAL_MONUMENT"
	
	// Археологические объекты (CategoryId = 3)
	case ancientSettlement    = "ANCIENT_SETTLEMENT"
	case hillfort             = "HILLFORT"
	case burialMound          = "BURIAL_MOUND"
	case ancientSettlementSite = "ANCIENT_SETTLEMENT_SITE"
	
	// Топонимические объекты (CategoryId = 4)
	case city                 = "CITY"
	case village              = "VILLAGE"
	case tract                = "TRACT"
	case viewpoint            = "VIEWPOINT"
	
	// Инфраструктурные объекты (CategoryId = 5)
	case touristRoute         = "TOURIST_ROUTE"
	case touristCamp          = "TOURIST_CAMP"
	case museum               = "MUSEUM"
	case visitorCenter        = "VISITOR_CENTER"
	case ecologicalTrail      = "ECOLOGICAL_TRAIL"
	
	case unknown              = "UNKNOWN"
	
	var icon: Image {
		switch self {
				// Историко-культурное наследие
			case .militaryMemorial, .personMonument, .eventMonument, .memorialPlaque, .technicalMonument:
				Image("map_icon_monument")
			case .sculpture:
				Image("map_icon_sculpture")
			case .orthodoxChurch, .monastery, .chapel, .holySpring:
				Image("map_icon_church")
			case .manor, .manorPark:
				Image("map_icon_manor")
			case .historicalBuilding, .merchantHouse:
				Image("map_icon_historical_building")
			case .industrialObject, .waterTower:
				Image("map_icon_industrial")
			case .bridge:
				Image("map_icon_bridge")
			case .railwayStation:
				Image("map_icon_railway")
				
				// Природные объекты
			case .river, .lake, .pond, .spring:
				Image("map_icon_water")
			case .ravine, .hill, .valley:
				Image("map_icon_landscape")
			case .quarry, .cave:
				Image("map_icon_quarry")
			case .oldTree, .grove, .alley:
				Image("map_icon_tree")
			case .park, .nationalPark, .natureReserve, .naturalMonument:
				Image("map_icon_park")
				
				// Археологические объекты
			case .ancientSettlement, .hillfort, .burialMound, .ancientSettlementSite:
				Image("map_icon_archaeology")
				
				// Топонимические объекты
			case .city, .village, .tract:
				Image("map_icon_settlement")
			case .viewpoint:
				Image("map_icon_viewpoint")
				
				// Инфраструктурные объекты
			case .touristRoute, .ecologicalTrail:
				Image("map_icon_route")
			case .touristCamp:
				Image("map_icon_camp")
			case .museum:
				Image("map_icon_museum")
			case .visitorCenter:
				Image("map_icon_visitor_center")
				
			case .unknown:
				Image("map_icon_unknown")
		}
	}
	
	var categoryId: Int {
		switch self {
				// Историко-культурное наследие (CategoryId = 1)
			case .militaryMemorial, .personMonument, .eventMonument, .memorialPlaque, .technicalMonument,
					.sculpture, .orthodoxChurch, .monastery, .chapel, .holySpring, .manor, .manorPark,
					.historicalBuilding, .merchantHouse, .industrialObject, .waterTower, .bridge, .railwayStation:
				return 1
				
				// Природные объекты (CategoryId = 2)
			case .river, .lake, .pond, .spring, .ravine, .hill, .valley, .quarry, .cave,
					.oldTree, .grove, .alley, .park, .nationalPark, .natureReserve, .naturalMonument:
				return 2
				
				// Археологические объекты (CategoryId = 3)
			case .ancientSettlement, .hillfort, .burialMound, .ancientSettlementSite:
				return 3
				
				// Топонимические объекты (CategoryId = 4)
			case .city, .village, .tract, .viewpoint:
				return 4
				
				// Инфраструктурные объекты (CategoryId = 5)
			case .touristRoute, .touristCamp, .museum, .visitorCenter, .ecologicalTrail:
				return 5
				
			case .unknown:
				return 0
		}
	}
}

struct GenericType: Codable, Identifiable {
	let id: Int
	let name: String
	let title: String
	
	var geoObjectType: GeoObjectType {
		return GeoObjectType(rawValue: name) ?? .unknown
	}
}
