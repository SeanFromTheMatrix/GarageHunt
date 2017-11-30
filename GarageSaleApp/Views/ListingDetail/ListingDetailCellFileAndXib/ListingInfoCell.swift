//
//  ListingInfoCell.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 11/17/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit

class ListingInfoCell: UITableViewCell {

    @IBOutlet weak var listingTitle: UILabel!
    @IBOutlet weak var listingAddress: UILabel!
    @IBOutlet weak var listingDescription: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
