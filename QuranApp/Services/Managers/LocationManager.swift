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

    let storageKey:String = "location"

    @Published var authorizationStatus: Bool = false
    @Published var loading: Bool = false
    @Published var location: LocationModel = LocationModel(lang: 0, lat: 0)
    
    override init() {
        super.init()
        self.manager.delegate = self
        getLocation()
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
        self.loading = true
    }
    
    func getLocation() {
        if let data = UserDefaults.standard.data(forKey: storageKey), let savedLocation = try? JSONDecoder().decode(LocationModel.self, from: data) {
            self.location = savedLocation
        } else {
            request()
        }
    }
    
    func saveLocation() {
        if let encodedData = try? JSONEncoder().encode(location) {
            UserDefaults.standard.set(encodedData, forKey: storageKey)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let data = locations.first?.coordinate
        self.location = LocationModel(lang: Double(data?.longitude ?? 0), lat: Double(data?.latitude ?? 0))
        guard locations.last != nil else { return }
        self.manager.stopUpdatingLocation()
        self.loading = false
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
