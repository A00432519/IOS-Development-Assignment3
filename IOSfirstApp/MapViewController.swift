//
//  MapViewController.swift
//  IOSfirstApp
//
//  Created by Sidharth Bhalla on 2019-07-27.
//  Copyright © 2019 Sidharth Bhalla. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapview: MKMapView!
    
    var wonderLocation: CLLocation?
    var wonderLocation2: CLLocation?
    var wonderName: String?
    var currentLocation: CLLocation?
    let manager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("wonderLocation: \(wonderLocation)")
        print("wonderLocation2: \(wonderLocation2)")
        print("wonderName: \(wonderName)")
        //print("Annotion Coordinates: \(annotations)")
        mapview.delegate = self
        setupMapView()
        setupLocationManager()
    

        // Do any additional setup after loading the view.
    }
    func setupMapView(){
        let coordinate = wonderLocation?.coordinate
        let coordinate2 = wonderLocation2?.coordinate
        print("coordinate2: \(coordinate2)")
        if let coordinate = coordinate, let name = wonderName {
            let annotation = MKPointAnnotation()
            annotation.title = name
            annotation.coordinate = coordinate 
            mapview.addAnnotation(annotation)

             zoom(annotation.coordinate)
        }
        if let coordinate2 = coordinate2 {
            let annotation2 = MKPointAnnotation()
            annotation2.title = "Nearby"
            annotation2.coordinate = coordinate2
            mapview.addAnnotation(annotation2)

        }
        
        mapview.showsUserLocation = true
    }
    func zoom(_ location: CLLocationCoordinate2D) {
        let radius = 1000
        let region = MKCoordinateRegion(center: location, latitudinalMeters: CLLocationDistance(Double(radius) * 2.0), longitudinalMeters: CLLocationDistance(Double(radius) * 2.0))
        mapview.setRegion(region, animated: true)
        
    }
    
    func setupLocationManager() {
        if CLLocationManager.authorizationStatus() == .notDetermined{
            manager.requestWhenInUseAuthorization()
        }
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.delegate = self
        manager.stopUpdatingLocation()
    }

}
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "reusePin")
        view.canShowCallout = true
        view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
        if annotation.title == "Nearby" {
            view.pinTintColor = UIColor.red
        }
        else {
            view.pinTintColor = UIColor.green
        }

        return view

    }

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation
        let launchingOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        if let coordinate = view.annotation?.coordinate {
            let mapItem = location?.mapItem(coordinate: coordinate)
            mapItem?.openInMaps(launchOptions: launchingOptions)
        }

    }
}
extension MKAnnotation {
    func mapItem(coordinate: CLLocationCoordinate2D) -> MKMapItem {
        let placeMark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placeMark)
        return mapItem
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.currentLocation = location
        updateLocation(location)
    }
    private func updateLocation(_ currentLocation: CLLocation){
        self.currentLocation = currentLocation
    }
}
