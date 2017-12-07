//
//  ListingDetailViewController.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 12/2/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit
import MapKit

class ListingDetailViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var listingPhoto: UIImageView!
    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var listingKeyPhrases: UITextView!
    @IBOutlet weak var listingDescription: UITextView!
    @IBOutlet weak var listingAddress: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    // Properties
    var listingToDisplay : Listing!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        listingTitle.text = listingToDisplay.name
        listingDescription.text = listingToDisplay.description
        listingAddress.text = listingToDisplay.streetAddress + ", " + listingToDisplay.city + ", " + listingToDisplay.state + ", " + "\(listingToDisplay.zip)"
        listingPhoto.downloadImageFrom0(link: listingToDisplay.imageURLString)
        
        let location = CLLocationCoordinate2DMake(listingToDisplay.latitude, listingToDisplay.longitude)
        mapView.setRegion(MKCoordinateRegionMakeWithDistance(location, 1000, 1000), animated: true)
        
        let pin = PinAnnotation(title: "\(listingToDisplay.name)", subtitle: "Near You", coordinate: location)
        
        mapView.addAnnotation(pin)
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
    }    
}
