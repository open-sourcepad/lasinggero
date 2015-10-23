//
//  OccassionTableViewController.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit
import Alamofire

class OccassionTableViewController: UITableViewController {

    var occassionList:NSMutableArray = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "occassionCell")
        loadOccassion()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return occassionList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("occassionCell", forIndexPath: indexPath)

        // Configure the cell...
        let occassion = occassionList[indexPath.row] as! Occassion
        cell.textLabel?.text = occassion.occTitle as! String
        return cell
    }
    
    func loadOccassion() {
        let manager = Alamofire.Manager.sharedInstance
        let authToken = NSUserDefaults.standardUserDefaults().objectForKey("authToken") as! String
        let params = ["authentication_token": "\(authToken)"]
        manager.request(.GET, OCCASSION_API, parameters: params)
            .responseJSON { response in
                debugPrint(response)
                if response.result.error == nil {
                    debugPrint(response.result.value)
                    let data = response.result.value as! NSDictionary
                    
                    let occassionData = data["occasions"] as! NSArray
                        for occassions in occassionData{
                            let occ = occassions as! NSDictionary
                            let occassion = Occassion()
                            occassion.occId = occ.objectForKey("id") as! Int
                            occassion.occTitle = occ["title"] as! String
                            occassion.occLocation = occ["location"] as! String
                            self.occassionList.addObject(occassion)
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
