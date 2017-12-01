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

var myLightGray = UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.0)

class ListingVC: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var itemsTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!

//    @IBOutlet weak var keyPhraseTextView: UITextView!
//    @IBOutlet weak var listingDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let center: NotificationCenter.default
//        center.addObserver(self, selector: #selector(keyboardDidSAhow(notifications)))
        
        ref = Database.database().reference()
        
    }
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        print("imagepickerinitiated")
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func saveListing(_ sender: UIBarButtonItem) {
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
            
            let listingID = String(describing: Date())
            
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
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        scrollView.setContentOffset(CGPoint(x: 0, y: 250), animated: true)
//
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
//    }
    
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

