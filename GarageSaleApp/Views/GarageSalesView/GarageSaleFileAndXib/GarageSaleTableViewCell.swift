//
//  GarageSaleTableViewCell.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 11/20/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit

class GarageSaleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var garageSaleImage: UIImageView!
    @IBOutlet weak var garageSaleTitle: UILabel!
    @IBOutlet weak var garageSaleAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
