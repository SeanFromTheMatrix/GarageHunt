//
//  TableViewCell.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 11/17/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit

class ListingDetailImageCell: UITableViewCell {

    @IBOutlet weak var listingImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
