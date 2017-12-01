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

class ListingVC: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var ref: DatabaseReference!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var itemsTextField: UITextView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var streetTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!

    @IBOutlet weak var keyPhraseTextView: UITextView!
    @IBOutlet weak var listingDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // adds borders and place holder text to textViews
        keyPhraseTextView!.layer.borderWidth = 1
        keyPhraseTextView!.layer.borderColor = myLightGray.cgColor
        keyPhraseTextView.delegate = self
        keyPhraseTextView.text = "Use key phrases like electronics, desk or similar phrases to tag your items. Tags are searchable phrases that let others easily search for your items."
        keyPhraseTextView.textColor = myLightGray
        
        listingDescriptionTextView!.layer.borderWidth = 1
        listingDescriptionTextView!.layer.borderColor = myLightGray.cgColor
        listingDescriptionTextView.delegate = self
        listingDescriptionTextView.text = "Use this space to describe your items in detail."
        listingDescriptionTextView.textColor = myLightGray
        
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if keyPhraseTextView.textColor == myLightGray {
            keyPhraseTextView.text = ""
            keyPhraseTextView.textColor = .black
        }
        if listingDescriptionTextView.textColor == myLightGray {
            listingDescriptionTextView.text = ""
        listingDescriptionTextView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {

        if keyPhraseTextView.text == "" {
            keyPhraseTextView.text = "Use key phrases like electronics, desk or similar phrases to tag your items. Tags are searchable phrases that let others easily search for your items."
            keyPhraseTextView.textColor = myLightGray
            
        }
        
        if listingDescriptionTextView.text == "" {
            listingDescriptionTextView.text = "Use this space to descript your items in detail."
        listingDescriptionTextView.textColor = myLightGray
            
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

