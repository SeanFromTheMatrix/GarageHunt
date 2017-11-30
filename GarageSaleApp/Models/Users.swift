//
//  Products.swift
//  TomsGAmazon
//
//  Created by Thomas Neary on 11/13/17.
//  Copyright © 2017 OpCon Technologies, Inc. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Users {
    var name: String
    var uid: String
    var type: String
    var email: String
    var timeStamp: TimeInterval?
    let ref: DatabaseReference?
    
    init(name: String, uid: String, type: String, email: String, timeStamp: TimeInterval) {
        self.name = name
        self.uid = uid
        self.type = type
        self.email = email
        self.timeStamp = timeStamp
        self.ref = nil
    }
    
    init(snapshotFunction: DataSnapshot) {
        let snapshotValue = snapshotFunction.value as! [String: AnyObject]
        name = snapshotValue["name"] as! String
        uid = snapshotValue["uid"] as! String
        type = snapshotValue["type"] as! String
        email = snapshotValue["email"] as! String
        timeStamp = snapshotValue["timeStamp"] as? Double
        ref = snapshotFunction.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "uid": uid,
            "type": type,
            "email": email,
            "timeStamp": timeStamp ?? 0.0
        ]
    }
    
}
