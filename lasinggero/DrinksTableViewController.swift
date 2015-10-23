//
//  DrinksTableViewController.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/24/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit
import Alamofire

class DrinksTableViewController: UITableViewController {
    var drinksList:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "drinkSelectCell")
        loadDrinks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return drinksList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("drinkSelectCell", forIndexPath: indexPath)
        let drink = drinksList[indexPath.row] as! Drink
        cell.textLabel?.text = drink.drinkName
        // Configure the cell...
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let drink = drinksList[indexPath.row] as! Drink
        let manager = Alamofire.Manager.sharedInstance
        let authToken = NSUserDefaults.standardUserDefaults().objectForKey("authToken") as! String
        let params = ["authentication_token": "\(authToken)", "drink_id": "\(drink.drinkId)"]
        manager.request(.GET, "https://lasinggero.herokuapp.com/api/occasions/\(appDelegate.currOccassion.occId)", parameters: params)
            .responseJSON { response in
                debugPrint(response)
                let data = response.result.value as! NSDictionary
                let occassionData = data["occasion"] as! NSDictionary
                let occ = appDelegate.currOccassion
                occ.servingsLeft = occassionData["servings_left_until_max"] as! Int
                occ.percentageMax = occassionData["percentage_until_max"] as! Int
                appDelegate.currOccassion = occ
                self.presentThis(drink)
        }
    }
    
    func presentThis(drink: Drink) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let trackView = storyboard.instantiateViewControllerWithIdentifier("trackView") as! TrackViewController
        trackView.occassion = appDelegate.currOccassion
        trackView.currDrink = drink
        let navController = UINavigationController(rootViewController: trackView)
        self.presentViewController(navController, animated: true, completion: nil)
    }
    func loadDrinks() {
        let manager = Alamofire.Manager.sharedInstance
        let authToken = NSUserDefaults.standardUserDefaults().objectForKey("authToken") as! String
        let params = ["authentication_token": "\(authToken)"]
        manager.request(.GET, BENCHMARK_API, parameters: params)
            .responseJSON { response in
                debugPrint(response)
                if response.result.error == nil {
                    self.drinksList = []
                    debugPrint(response.result.value)
                    let data = response.result.value as! NSDictionary
                    let drinksData = data["drinks"] as! NSArray
                    for drinkVar in drinksData{
                        let drink = drinkVar as! NSDictionary
                        let drinkCat = Drink()
                        drinkCat.drinkId = drink.objectForKey("id") as! Int
                        drinkCat.drinkName = drink["name"] as! String
                        drinkCat.drinkCount = 0
                        drinkCat.drinkServingType = drink["serving_type"] as! String
                        drinkCat.drinkSize = drink["serving"] as! Double
                        self.drinksList.addObject(drinkCat)
                    }
                }
                self.tableView.reloadData()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
