//
//  File.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 11/15/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Listing {
    
    var name: String
    var listingImage: UIImage
//    var searchTags: [String]
//    var description: String
//    var price : String
    var streetAddress: String
    var city: String
    var state: String
    var zip: Int
//    var myListing: Bool
//    var latitude: Double
//    var longitude: Double
//    var nearbyListings: [Listing]
    
    // Called when Writing this Data Object
    func toAnyObject() -> Any {
        return [
            "name": name ,
            "listingImage": listingImage,
            "streetAddress": streetAddress,
            "city": city,
            "state": state,
            "zip": zip
        ]
    }
}
