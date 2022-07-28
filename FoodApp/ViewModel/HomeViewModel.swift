//
//  HomeViewModel.swift
//  FoodApp
//
//  Created by Ömer Faruk Kılıçaslan on 28.07.2022.
//

import Foundation
import CoreLocation

//Fetching user location

class HomeViewModel: NSObject,ObservableObject, CLLocationManagerDelegate {
    
    @Published var locationManager = CLLocationManager()
    @Published var search = ""
    
    //location details
    
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    //Menu
    @Published var showMenu = false
    
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        //checking location access
        
        switch manager.authorizationStatus {
            
        case .authorizedWhenInUse:
            print("authorized")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("denied")
            self.noLocation = true
        default:
            print("unknown user")
            self.noLocation = false
            //Direct call
            locationManager.requestWhenInUseAuthorization()
            //modifying info. plist
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // reading user location and extracting details
        
        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation() {
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { res, err in
            guard let safeData = res else {return}
            
            var address = ""
            
            //getting area and location name
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
}
