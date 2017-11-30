//
//  CustomNavController.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 11/14/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit

class CustomNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }

}
