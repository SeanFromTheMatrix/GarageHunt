//
//  TableViewController.swift
//  GarageSaleApp
//
//  Created by Sean Bukich on 11/17/17.
//  Copyright © 2017 Sean Bukich. All rights reserved.
//

import UIKit

class ListingDetailTVC: UITableViewController {
    
    let listingImageCell = ListingDetailImageCell()
    let listingDetailCell = ListingInfoCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "ListingDetailImageCell", bundle: nil), forCellReuseIdentifier: "ListingDetailImageCell")
        self.tableView.register(UINib(nibName: "ListingInfoCell", bundle:nil), forCellReuseIdentifier: "ListingInfoCell")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        //return arrayOfCellData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListingDetailImageCell", for: indexPath) as! ListingDetailImageCell
        return cell
    }
    
}
