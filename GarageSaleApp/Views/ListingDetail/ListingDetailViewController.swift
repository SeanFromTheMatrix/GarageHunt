//
//  ListingDetailViewController.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 12/2/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit
import MapKit

class ListingDetailViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // Outlets
    @IBOutlet weak var listingPhoto: UIImageView!
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var listingKeyPhrases: UITextView!
    @IBOutlet weak var listingDescription: UITextView!
    @IBOutlet weak var listingAddress: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    // Properties
    let locationManager = CLLocationManager()
    var listingToDisplay : Listing!
    var pinStuff: [PinAnnotation] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var searchTag = String()
        
        // give round edges to text boxes

        
        listingKeyPhrases.layer.cornerRadius = 4.5
        listingKeyPhrases.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        listingKeyPhrases.layer.borderWidth = 0.5
        listingKeyPhrases.clipsToBounds = true
        
        listingDescription.layer.cornerRadius = 4.5
        listingDescription.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        listingDescription.layer.borderWidth = 0.5
        listingDescription.clipsToBounds = true
        
        listingAddress.layer.cornerRadius = 4.5
        listingAddress.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        listingAddress.layer.borderWidth = 0.5
        listingAddress.clipsToBounds = true
        
        
        listingTitle.text = listingToDisplay.name
        listingDescription.text = listingToDisplay.description
        for tag in listingToDisplay.searchTags {
            searchTag += "\(tag),"
        }
        
        let commalessSearchTag = searchTag.dropLast()
        
        listingKeyPhrases.text = String(commalessSearchTag)
        listingAddress.text = listingToDisplay.streetAddress + ", " + listingToDisplay.city + ", " + listingToDisplay.state + ", " + "\(listingToDisplay.zip)"
        listingPhoto.downloadImageFrom0(link: listingToDisplay.imageURLString)
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        let sourceCoordinates = locationManager.location?.coordinate
        let destCoordinates = CLLocationCoordinate2DMake(listingToDisplay.latitude, listingToDisplay.longitude)
        
        let sourcePlacemarks = MKPlacemark(coordinate: sourceCoordinates!)
        let destPlacemarks = MKPlacemark(coordinate: destCoordinates)
        
        let sourceItem = MKMapItem(placemark: sourcePlacemarks)
        let destItem = MKMapItem(placemark: destPlacemarks)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = sourceItem
        directionRequest.destination = destItem
        directionRequest.transportType = .automobile
        directionRequest.transportType = .walking

        let directions = MKDirections(request: directionRequest)
        directions.calculate(completionHandler: {
            response, error in
            
            guard let response = response else {
                if let error = error {
                    print("something went wrong")
                }
                return
            }
            let route = response.routes[0]
            self.mapView.add(route.polyline, level: .aboveRoads)
            
            let rekt = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegionForMapRect(rekt), animated: true)
        })
        
        let location = CLLocationCoordinate2DMake(listingToDisplay.latitude, listingToDisplay.longitude)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 1000, 1000), animated: true)
        
        let pin = PinAnnotation(title: "\(listingToDisplay.name)", subtitle: "Near You", coordinate: location)
        
        mapView.addAnnotation(pin)
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 5.0
        return renderer
    }
}

extension ListingDetailViewController {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? PinAnnotation else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! PinAnnotation
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}











