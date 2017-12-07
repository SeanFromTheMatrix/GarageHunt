//
//  ViewController.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 12/1/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
