//
//  GarageSalesTVC.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 11/19/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit
import FirebaseDatabase

class GarageSalesTVC: UITableViewController {
    
    var ref: DatabaseReference?
    var arrayOfCellData = [Listing]()
    var userData: Users?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfCellData = [Listing(name: "garage sale", listingImage: #imageLiteral(resourceName: "yard-sale-backyard"), streetAddress: "24795 Crown Royale", city: "Laguna Niguel", state: "Ca", zip: 92677)]
        tableView.register(UINib(nibName: "GarageSaleTableViewCell", bundle: nil), forCellReuseIdentifier: "GarageSaleTableViewCell")
        
        ref = Database.database().reference()
        
        ref?.child("Listing").observe(.value) {
            (snapshot) in
            print("made it into observer, response from server")
            guard let listings = snapshot.value as? [String : Any] else {
                print("not able to convert snapshot to dictionary")
                return
            }
            
            self.arrayOfCellData = []

            for (_, listing) in listings {
                if let listingDictionary = listing as? [String : String] {
                    if let name = listingDictionary["title"],
                        let street = listingDictionary["street"],
                        let city = listingDictionary["city"],
                        let state = listingDictionary["state"],
                        let zipString = listingDictionary["zipCode"],
                        let zip = Int(zipString)
                    {
                        self.arrayOfCellData.append(Listing(name: name, listingImage: #imageLiteral(resourceName: "yard-sale-backyard"), streetAddress: street, city: city, state: state, zip: zip))
                        print("array count is ", self.arrayOfCellData.count)
                    } else {
                        print("we were not able to get all values for listing", listingDictionary["title"] as? String ?? "nil", listingDictionary["street"] as? String ?? "nil", listingDictionary["city"] as? String ?? "nil", listingDictionary["state"] as? String ?? "nil", listingDictionary["zipCode"] as? Int ?? "nil")
                        print("zip is ", listingDictionary["zipCode"])
                    }
                } else {
                    print("could not get listing dictionary as [string : any]")
                }
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {return 85}

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GarageSaleTableViewCell", for: indexPath) as! GarageSaleTableViewCell
        let listing = arrayOfCellData[indexPath.row]
        cell.garageSaleTitle.text = listing.name
        cell.garageSaleImage.image = listing.listingImage
        cell.garageSaleAddress.text = listing.streetAddress + ", " + listing.city + ", " + listing.state + ", " + "\(listing.zip)"
        return cell
    }

}
