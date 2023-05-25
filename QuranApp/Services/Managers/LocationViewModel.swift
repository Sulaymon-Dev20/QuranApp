//
//  LicationViewModel.swift
//  QuranApp
//
//  Created by Sulaymon on 24/05/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    let kLatitudeKey = "latitude"
    let kLongitudeKey = "longitude"

    @Published var authorizationStatus: Bool = false
    @Published var location: CLLocationCoordinate2D?
    @Published var items:[JuzModel] = []
    
    override init() {
        super.init()
        self.manager.delegate = self
    }

    public func requestAuthorisation(always: Bool = false) {
        if always {
            self.manager.requestAlwaysAuthorization()
        } else {
            self.manager.requestWhenInUseAuthorization()
        }
    }
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    func request() {
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }
    
    func getLocation() {
        let defaults = UserDefaults.standard
        if let latitude = defaults.value(forKey: kLatitudeKey) as? Double, let longitude = defaults.value(forKey: kLongitudeKey) as? Double {
            self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        } else {
            request()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.first?.coordinate
        guard let location = locations.last else { return }
        let defaults = UserDefaults.standard
        defaults.set(location.coordinate.latitude, forKey: kLatitudeKey)
        defaults.set(location.coordinate.longitude, forKey: kLongitudeKey)
        self.manager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
         switch manager.authorizationStatus {
         case .authorizedWhenInUse:  // Location services are available.
             authorizationStatus = true
             break
         case .restricted:  // Location services currently unavailable.
             authorizationStatus = false
             break
         case .denied:  // Location services currently unavailable.
             authorizationStatus = false
             break
         case .notDetermined:  // Authorization not determined yet.
             authorizationStatus = false
             break
         default:
             break
         }
     }
    
    func checkLocationPermission() -> Bool {
        let locationManager = CLLocationManager()
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .denied, .restricted:
            return false
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return false
        @unknown default:
            return false
        }
    }
}
