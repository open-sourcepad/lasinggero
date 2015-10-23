//
//  AddOccassionViewController.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit
import Alamofire

class AddOccassionViewController: UIViewController {

    @IBOutlet weak var titleFld: UITextField!
    @IBOutlet weak var locationFld: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Add Occassion"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startOccassion(sender: AnyObject) {
        let manager = Alamofire.Manager.sharedInstance
        let authToken = NSUserDefaults.standardUserDefaults().objectForKey("authToken") as! String
        let occassionDict = ["title": "\(titleFld.text!)", "location": "\(locationFld.text!)"]
        let params:[String: AnyObject] = ["authentication_token": "\(authToken)", "occasion": occassionDict]
        
        manager.request(.POST, OCCASSION_API, parameters: params )
            .responseJSON {response in
                debugPrint(response)
                if response.result.error == nil {
                    let occData = response.result.value as! NSDictionary
                    let currData = occData["occasion"] as! NSDictionary
                    let drinkData = occData["drink"] as! NSDictionary
                    let newOccassion = Occassion()
                    newOccassion.occId = currData["id"] as! Int
                    newOccassion.occLocation = currData["location"] as! String
                    newOccassion.occTitle = currData["title"] as! String
                    newOccassion.percentageMax = currData["percentage_until_max"] as! Int
                    newOccassion.servingsLeft = currData["servings_left_until_max"] as! Int
                    let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let trackView = storyboard.instantiateViewControllerWithIdentifier("trackView") as! TrackViewController
                    trackView.occassion = newOccassion
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.currOccassion = newOccassion
                    let drinkCurr = Drink()
                    drinkCurr.drinkId = drinkData["id"] as! Int
                    drinkCurr.drinkName = drinkData["name"] as! String
                    trackView.currDrink = drinkCurr
                    let navController = UINavigationController(rootViewController: trackView)
                    self.presentViewController(navController, animated: true, completion: nil)
                }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
