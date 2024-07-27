//
//  LocationManager.swift
//  kraeved
//
//  Created by Владимир Амелькин on 13.07.2024.
//

import Foundation
import CoreLocation
import YandexMapsMobile
import Combine


//MARK: - LocationManager
final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    
    @Published var lastUserLocation: CLLocation? = nil
    
    lazy var map: YMKMap = {
        return mapView.mapWindow.map
    }()
    
    private let manager = CLLocationManager()
    
    var mapView: YMKMapView = {
        YMKMapView(frame: CGRect.zero)
    }()
    
    override init(){
        super.init()
        manager.delegate = self
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            self.manager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastUserLocation = locations.last
    }
    
    func centerMapLocation(target location: YMKPoint?, map: YMKMapView) {
        guard let location = location else { print("Failed to get user location"); return }
        map.mapWindow.map.move(
            with: YMKCameraPosition(target: location, zoom: 18, azimuth: 0, tilt: 0),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5)
        )
    }
    
    func currentUserLocation() {
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)
        
        if let myLocation = lastUserLocation {
            centerMapLocation(target: YMKPoint(latitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude), map: mapView)
            
            userLocationLayer.setVisibleWithOn(true)
            userLocationLayer.isHeadingEnabled = true
//            userLocationLayer.setAnchorWithAnchorNormal(
//                CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
//                anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
//            userLocationLayer.setObjectListenerWith(self)
        }
    }
}
