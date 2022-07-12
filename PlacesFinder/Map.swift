//
//  Map.swift
//  PlacesFinder
//
//  Created by New User on 10/07/22.
//

import Foundation
import MapKit
import UIKit
class Map :UIViewController{
    
    let locManager = CLLocationManager()
    var feed : [mapResponse]  = []
    
    
    @IBAction func centreLoc(_ sender: UIButton) {
        if let loc = locManager.location
        {
            let region = MKCoordinateRegion(center: loc.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
            map.setRegion(region, animated: true)
        }
    }
    @IBOutlet weak var map: MKMapView!
    override func viewDidLoad() {
        map.delegate = self
        if let loc = locManager.location
        {
            let region = MKCoordinateRegion(center: loc.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            map.setRegion(region, animated: true)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(updateMap), name: NSNotification.Name(rawValue: "placefinder.locationsUpdated"), object: nil)
        updateMap()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !CLLocationManager.locationServicesEnabled()
        {
            updateMap()
            let alert = UIAlertController(title: "please allow location", message: "Go to settings to allow location", preferredStyle: .alert)
            let alertItem = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(alertItem)
            self.present(alert , animated: true, completion: nil)
        }
    }
    
    @objc func updateMap(){
        if !feed.isEmpty{
            
            for feedElement in feed {
                let annotation = MKPointAnnotation()
                annotation.coordinate = feedElement.coOrrdinate
                annotation.title = feedElement.name
                map.addAnnotation(annotation)
            }
            
            
        }
        
        
    }
    
    
    //how to add current location , search for things in map
    
}
extension Map:MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        return annotationView
    }
}
