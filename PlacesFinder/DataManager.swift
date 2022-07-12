//
//  DataManager.swift
//  PlacesFinder
//
//  Created by New User on 11/07/22.
//

import Foundation
import MapKit
import CoreLocation
class DataManager : NSObject {
    
    let locationManager = CLLocationManager()
    let catagoriesOfSearch = ["cafe","restaurant","ice cream parlour"]
    var feed : [mapResponse]
    override init() {
        feed = []
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        if CLLocationManager.locationServicesEnabled()
        {
            locationManager.startUpdatingLocation()
        }
        searchForPlaces()
    }
    
    func searchForPlaces(){
        if let loc = locationManager.location
        {
            let region = MKCoordinateRegion(center: loc.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            let req = MKLocalSearch.Request()
            req.region = region
            for catagory in catagoriesOfSearch{
                
                req.naturalLanguageQuery = catagory
                let search = MKLocalSearch(request: req)
                
                search.start(completionHandler: { response,_ in
                    if let response = response {
//                        print("local search response is :- \(response)")
                        for mapitem in response.mapItems{
                            self.feed.append(mapResponse(name: mapitem.name ?? " ", coOrrdinate: mapitem.placemark.coordinate, phoneNumber: mapitem.phoneNumber ?? " "))
                        }
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "placefinder.locationsUpdated"), object: nil)
                        
                    }
                })
            }
        }
        
        
    }
}
extension DataManager : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error in location manager:- \(error)")
    }
    
}
struct mapResponse{
    var name : String
    var coOrrdinate : CLLocationCoordinate2D
    var phoneNumber : String
    
}
