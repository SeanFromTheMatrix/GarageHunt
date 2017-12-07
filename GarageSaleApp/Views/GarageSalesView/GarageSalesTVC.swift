
import UIKit
import FirebaseDatabase
import FirebaseAuth

class GarageSalesTVC: UITableViewController {
    
    var ref: DatabaseReference?
    var arrayOfCellData = [Listing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        arrayOfCellData = [Listing(name: "garage sale", imageURLString: "", description: "", streetAddress: "24795 Crown Royale", city: "Laguna Niguel", state: "Ca", zip: 92677, latitude: 0.0, longitude: 0.0)]
        tableView.register(UINib(nibName: "GarageSaleTableViewCell", bundle: nil), forCellReuseIdentifier: "GarageSaleTableViewCell")
            fillTable()
        
    }

    func fillTable() {
        ref = Database.database().reference()
        ref?.child("Listing").observe(.value) {
            (snapshot) in
            print("made it into observer, response from server")
            guard let listings = snapshot.value as? [String : Any] else {
                print("not able to convert snapshot to dictionary")
                return
            }
            printDebugListingCells(String(#line), "listings.count: \(listings.count)")
            self.arrayOfCellData = []
            for (_, listing) in listings {
                if let listingDictionary = listing as? [String : String] {
                    if let name = listingDictionary["title"],
                        let description = listingDictionary["description"],
                        let street = listingDictionary["street"],
                        let city = listingDictionary["city"],
                        let latitude = listingDictionary["latitude"],
                        let longitude = listingDictionary["longitude"],
                        let state = listingDictionary["state"],
                        let zipString = listingDictionary["zipCode"],
                        let imageURL = listingDictionary["imageURL"],
                        let lat = Double(latitude),
                        let long = Double(longitude),
                        let zip = Int(zipString) {
                        
                        self.arrayOfCellData.append(Listing(name: name, imageURLString: imageURL, description: description, streetAddress: street, city: city, state: state, zip: zip, latitude: lat, longitude: long))
                        print("array count is ", self.arrayOfCellData.count)
                        
                    } else {
//                        print("we were not able to get all values for listing", listingDictionary["title"] as? String ?? "nil", listingDictionary["street"] as? String ?? "nil", listingDictionary["city"] as? String ?? "nil", listingDictionary["state"] as? String ?? "nil", listingDictionary["zipCode"] as? Int ?? "nil")
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
    
    @IBAction func logoutTouched(_ sender: UIButton) {
        print("logout touched")
        dismiss(animated: true)
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Goodbye!")
        } catch let signOutError as Error {
            print ("Error signing out: %@", signOutError)
        }
    }
}

extension GarageSalesTVC {
    
    //TABLEVIEW FUNCTIONS
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfCellData.count
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 85
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GarageSaleTableViewCell", for: indexPath) as! GarageSaleTableViewCell
        let listing = arrayOfCellData[indexPath.row]
        cell.garageSaleTitle.text = listing.name
        cell.garageSaleImage.downloadImageFrom0(link: listing.imageURLString)
        printDebugListingCells(String(#line), "indexPath.row \(indexPath.row)")
        cell.garageSaleAddress.text = listing.streetAddress + ", " + listing.city + ", " + listing.state + ", " + "\(listing.zip)"
        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextVC = segue.destination as? ListingDetailViewController {
            if let product = sender as? Listing  {
                nextVC.listingToDisplay = product
            }
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ListingDetail", sender: arrayOfCellData[indexPath.row])
    }
}
extension UIImageView {
    func downloadImageFrom0(link: String)  {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
            }
            DispatchQueue.main.async {
                self.image = nil
                self.contentMode =  UIViewContentMode.scaleAspectFill
                if let data = data {
                    self.image = UIImage(data: data)
                }
            }
        }).resume()
    }
}

func printDebugListingCells(_ line: String, _ message: String){
    print("DebugListingCells>>>>", line, message)
    
}














