//
//  User.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit
import Foundation

class User: NSObject {
    var name: String = ""
    var email: String = ""
    var authToken: String = ""
    
    func createCurrentUser(userData: NSDictionary)  {
        let currentUser = User()
        currentUser.name = userData.objectForKey("name") as! String
        currentUser.email = userData.objectForKey("email") as! String
        
        let appDelegate = AppDelegate()
        appDelegate.currentUser = currentUser
//        let userDefault = NSUserDefaults.standardUserDefaults()
//        userDefault.setObject(currentUser, forKey: "currentUser")
    }

}




