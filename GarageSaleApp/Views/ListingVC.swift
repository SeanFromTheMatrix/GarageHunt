//
//  ViewController.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 11/14/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import CoreLocation

var myLightGray = UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0)

class ListingVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref: DatabaseReference!
    var listing: Listing?
    var myLatitude: Double?
    var myLongitude: Double?
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextView!
    @IBOutlet weak var itemsTextField: UITextView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var streetTextField: UITextView!
    @IBOutlet weak var cityTextField: UITextView!
    @IBOutlet weak var stateTextField: UITextView!
    @IBOutlet weak var zipTextField: UITextView!

//    @IBOutlet weak var keyPhraseTextView: UITextView!
//    @IBOutlet weak var listingDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // give round edges to text boxes
        titleTextField.layer.cornerRadius = 4.5
        titleTextField.delegate = self
        titleTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        titleTextField.layer.borderWidth = 0.5
        titleTextField.text = "Name your garage sale"
        titleTextField.textColor = UIColor.lightGray
        titleTextField.clipsToBounds = true
        
        itemsTextField.layer.cornerRadius = 4.5
        itemsTextField.delegate = self
        itemsTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        itemsTextField.layer.borderWidth = 0.5
        itemsTextField.text = "Use some key phrases to describe your listing"
        itemsTextField.textColor = UIColor.lightGray
        itemsTextField.clipsToBounds = true
        
        descriptionTextField.layer.cornerRadius = 4.5
        descriptionTextField.delegate = self
        descriptionTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        descriptionTextField.layer.borderWidth = 0.5
        descriptionTextField.text = "Use this space to describe your listing in detail"
        descriptionTextField.textColor = UIColor.lightGray
        descriptionTextField.clipsToBounds = true
        
        streetTextField.layer.cornerRadius = 4.5
        streetTextField.delegate = self
        streetTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        streetTextField.layer.borderWidth = 0.5
        streetTextField.text = "Street Address"
        streetTextField.textColor = UIColor.lightGray
        streetTextField.clipsToBounds = true
        
        cityTextField.layer.cornerRadius = 4.5
        cityTextField.delegate = self
        cityTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        cityTextField.layer.borderWidth = 0.5
        cityTextField.text = "City"
        cityTextField.textColor = UIColor.lightGray
        cityTextField.clipsToBounds = true
        
        stateTextField.layer.cornerRadius = 4.5
        stateTextField.delegate = self
        stateTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        stateTextField.layer.borderWidth = 0.5
        stateTextField.text = "State"
        stateTextField.textColor = UIColor.lightGray
        stateTextField.clipsToBounds = true
        
        zipTextField.layer.cornerRadius = 4.5
        zipTextField.delegate = self
        zipTextField.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        zipTextField.layer.borderWidth = 0.5
        zipTextField.text = "Zipcode"
        zipTextField.textColor = UIColor.lightGray
        zipTextField.clipsToBounds = true
    
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        self.navigationController!.navigationBar.isTranslucent = true
        
        ref = Database.database().reference()
        
        //dismiss keyboard with tap outside of keyboard
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        
        NotificationCenter.default.addObserver(self, selector: #selector(ListingVC.keyboardWillShow(sender:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ListingVC.keyboardWillHide(sender:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    @objc func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if titleTextField.textColor == UIColor.lightGray {
            titleTextField.text = nil
            titleTextField.textColor = UIColor.black
        }
        if itemsTextField.textColor == UIColor.lightGray {
            itemsTextField.text = nil
            itemsTextField.textColor = UIColor.black
        }
        if descriptionTextField.textColor == UIColor.lightGray {
            descriptionTextField.text = nil
            descriptionTextField.textColor = UIColor.black
        }
        if streetTextField.textColor == UIColor.lightGray {
            streetTextField.text = nil
            streetTextField.textColor = UIColor.black
        }
        if cityTextField.textColor == UIColor.lightGray {
            cityTextField.text = nil
            cityTextField.textColor = UIColor.black
        }
        if stateTextField.textColor == UIColor.lightGray {
            stateTextField.text = nil
            stateTextField.textColor = UIColor.black
        }
        if zipTextField.textColor == UIColor.lightGray {
            zipTextField.text = nil
            zipTextField.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if titleTextField.text.isEmpty {
            titleTextField.text = "Name your garage sale"
            titleTextField.textColor = UIColor.lightGray
        }
        if itemsTextField.text.isEmpty {
            itemsTextField.text = "Use some key phrases to describe your listing"
            itemsTextField.textColor = UIColor.lightGray
        }
        if descriptionTextField.text.isEmpty {
            descriptionTextField.text = "Use this space to describe your listing in detail"
            descriptionTextField.textColor = UIColor.lightGray
        }
        if streetTextField.text.isEmpty {
            streetTextField.text = "Street Address"
            streetTextField.textColor = UIColor.lightGray
        }
        if cityTextField.text.isEmpty {
            cityTextField.text = "City"
            cityTextField.textColor = UIColor.lightGray
        }
        if stateTextField.text.isEmpty {
            stateTextField.text = "State"
            stateTextField.textColor = UIColor.lightGray
        }
        if zipTextField.text.isEmpty {
            zipTextField.text = "Zipcode"
            zipTextField.textColor = UIColor.lightGray
        }
    }
    

    
    //Dismiss key board
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        print("imagepickerinitiated")
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func convertAddress(address: String) {

        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            print("checking cooords")
              if let placemarks = placemarks,
                var location = placemarks.first?.location {

               self.myLatitude = location.coordinate.latitude
                self.myLongitude = location.coordinate.longitude

                print("my cooords \(location.coordinate.latitude)")
                print("my cooords \(location.coordinate.longitude)")

              } else {
                    // handle no location found
                print("cant find location")
            }

            // Use your location
        }
    }
    
    
    
    @IBAction func saveListing(_ sender: UIButton) {
        print("hi")
        
        guard let id = Auth.auth().currentUser?.uid else { return }
        if let title = titleTextField.text, !title.isEmpty,
            let item = itemsTextField.text, !item.isEmpty,
            let description = descriptionTextField.text, !description.isEmpty,
            let street = streetTextField.text, !street.isEmpty,
            let city = cityTextField.text, !city.isEmpty,
            let state = stateTextField.text, !state.isEmpty,
            let zipCode = zipTextField.text, !zipCode.isEmpty,
            let listingImage = photoImageView {
            
           // "1 Infinite Loop, Cupertino, CA 95014"
            let fullAdress = "\(street)," + "" + "\(city)," + "" + "\(state)," + "" + "\(zipCode)"
            print("******", fullAdress)
            print("ejaz is ugly \(fullAdress)")
            let listingID = String(describing: Date())
            convertAddress(address: fullAdress)
            
            let imageName = NSUUID().uuidString
            let storageRef = Storage.storage().reference().child("listing_images").child("\(imageName).png")
            
            if let uploadData = UIImagePNGRepresentation(self.photoImageView.image!) {
                storageRef.putData(uploadData, metadata: nil) {
                    (metadata, error) in
                    if error != nil {
                        print(" the error is : ", error)
                        return
                    }
                    print("here is the metadata: ", metadata, metadata?.downloadURL())
                    let listingDictionary = [
                        "title" : title,
                        "item" : item,
                        "description" : description,
                        "street" : street,
                        "city" : city,
                        "state" : state,
                        "zipCode" : zipCode,
                        "longitude": "\(self.myLongitude!)",
                        "latitude": "\(self.myLatitude!)",
                        "uid" : id,
                        "imageURL" : metadata?.downloadURL()?.absoluteString
                        ]
                    self.ref.child("Listing").child(listingID).setValue(listingDictionary)
                    self.ref.child("Users").child(id).child("listings").child(listingID).setValue(listingID)
                }
            }
            
        } else {
            print("bye")
            let alert = UIAlertController(title: "Uh-Oh",
                                          message: "Sorry, all the text fields must be filled out to properly set up your garage sale",
                                          preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Ok",
                                             style: .default)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
            return
        }
        navigationController?.popViewController(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedPhoto
       //garageSaleImage = selectedPhoto
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated:true, completion: nil)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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

