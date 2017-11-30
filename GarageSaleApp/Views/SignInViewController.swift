//
//  SignInViewController.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 11/15/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
//import FBSDKLoginKit

class SignInViewController: UIViewController{//}, GIDSignInDelegate {

    // Point to the Users DB Object
    let refUsers = Database.database().reference(withPath: "Users")
    var myUser: Users!
    
    @IBOutlet weak var emailLogInTextField: UITextField!
    @IBOutlet weak var passwordLogInTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //GIDSignIn.sharedInstance().uiDelegate = self
       // GIDSignIn.sharedInstance().signIn()
        
        //1
        Auth.auth().addStateDidChangeListener() { auth, user in
            //2
            if user != nil {
                print("hi")
                //3
                self.findCurrentUserObject()
            }
        }
    }
    func findCurrentUserObject() {
        
        Auth.auth().addStateDidChangeListener() { auth, user in
            
            guard (user != nil) else {
                print("Nobody is loggded in...")
                // push login view
                return
            }
            
            
            // Run the query...Check all uid's and return the one that matches the logged in user?uid
            self.refUsers.queryOrdered(byChild: "uid").queryEqual(toValue: "\(user?.uid  ?? "uid missing")").observe(.value, with: { snapshot in
                
                guard !(snapshot.value is NSNull) else {
                    print("Database Query of User did not Find a Matching User")
                    // push login view
                    return
                }
                
                // Capture the found User Object into the Users Model Instance
                print(snapshot.children.allObjects)
                self.myUser = Users(snapshotFunction: snapshot.children.nextObject() as! DataSnapshot)
                
                // Check that the uid of User Object Instance matches uid of the logged In User
                guard (self.myUser.uid == user?.uid) else {
                    print("User ID (uid) Match Failed")
                    print("Found user id:\n\(self.myUser.uid ?? "missing") \nDoes not match logged in user id: \n\(user?.uid ?? "missing")")
                    return
                }
                
                // Let the console know data from the User Object is now ready
                print("User ID (uid) Matched....\nFound uid: \n\(self.myUser.uid ?? "missing") \nMatches the logged in uid \n\(user?.uid ?? "missing")")
                print("\n***\nUser Data is Ready for:\n \(self.myUser.email)\n***\n")
                
                // Push the Home Screen
                self.performSegue(withIdentifier: "LoginToList", sender: nil)
                
            })
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginToList" {
            let navController = segue.destination as! UINavigationController
            let detailController = navController.topViewController as! GarageSalesTVC
            detailController.userData = myUser
        }
    }
    
    @IBAction func signInDidTouch(_ sender: Any) {
        print("signin pressed")
        
        Auth.auth().signIn(withEmail: emailLogInTextField.text!, password: passwordLogInTextField.text!)
    }
    
    @IBAction func signUpDidTouch(_ sender: Any) {
        let alert = UIAlertController(title: "Register", message: "Register", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { action in
        let emailField = alert.textFields![0]
        let passwordField = alert.textFields![1]
        
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!) { user, error in
            
            guard (error == nil) else {
                print(error?.localizedDescription ?? "a sign-up error occured")
                return
            }
            
            Auth.auth().signIn(withEmail: self.emailLogInTextField.text!, password: self.passwordLogInTextField.text!)
            
            //
            // CREATE the person as an Object in Users in the Database
            // - Use thier email as the unique name for the User Object
            // - Make them a "Buyer" by default...
            // - Add a timestamp
            //
            let timestamp =  NSDate().timeIntervalSinceReferenceDate
            
            let newUser = Users(name: "unknown", uid: (user?.uid)!,
                                type: "Buyer", email: (user?.email)!,
                                timeStamp: timestamp)
            
            // Remove "." from user.email... "." are not allowed in object names
            let formatedEmail = user?.email?.replacingOccurrences(of: ".", with: "_")
            
            // WRITE this newly signed up User to the Database
            self.refUsers.child(formatedEmail!).setValue(newUser.toAnyObject())
            
        }
                                        
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .destructive)
        
        alert.addTextField { textEmail in
            textEmail.placeholder = "Enter your email"
        }
        
        alert.addTextField { textPassword in
            textPassword.isSecureTextEntry = true
            textPassword.placeholder = "Choose your password"
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)

    }
    
}
extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailLogInTextField {
            passwordLogInTextField.becomeFirstResponder()
        }
        if textField == passwordLogInTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
}
