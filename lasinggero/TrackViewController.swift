//
//  TrackViewController.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit
import Alamofire

class TrackViewController: UIViewController {

    @IBOutlet weak var servingTypeLabel: UILabel!
    @IBOutlet weak var shotsLabel: UILabel!
    @IBOutlet weak var drinkLabel: UILabel!
    
    @IBOutlet weak var labelView: UIView!
    var progressView: UIView!
    
    var occassion: Occassion!
    var currDrink: Drink!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressView = UIView(frame: CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        progressView.backgroundColor = UIColor.greenColor()
        view.addSubview(progressView)
        view.sendSubviewToBack(progressView)
        
        servingTypeLabel.center = CGPoint(x: SCREEN_CENTER_X, y: servingTypeLabel.center.y)
        shotsLabel.center = CGPoint(x: SCREEN_CENTER_X, y: shotsLabel.center.y)
        drinkLabel.center = CGPoint(x: SCREEN_CENTER_X, y: drinkLabel.center.y)


    }
    
    override func viewWillAppear(animated: Bool) {
        navigationItem.title = occassion.occTitle
        drinkLabel.text = currDrink.drinkName
        shotsLabel.text = String(occassion.servingsLeft)
        let shotType = currDrink.drinkServingType != "" ? currDrink.drinkServingType.uppercaseString :  "SHOTS"
        servingTypeLabel.text = "\(shotType) LEFT"
        updateProgressBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func addDrink(sender: AnyObject) {
        let manager = Alamofire.Manager.sharedInstance
        let authToken = NSUserDefaults.standardUserDefaults().objectForKey("authToken") as! String
        let API = "https://lasinggero.herokuapp.com/api/occasions/\(occassion.occId)/occasion_drink?authentication_token=\(authToken)"
        let params = ["drink_id": "\(currDrink.drinkId)"]
        
        manager.request(.POST, API, parameters: params )
            .responseJSON { response in
                debugPrint(response)
                if response.result.error == nil {
                    let occData = response.result.value as! NSDictionary
                    let currData = occData["occasion"] as! NSDictionary
                    self.occassion.servingsLeft = currData["servings_left_until_max"] as! Int
                    self.occassion.percentageMax = currData["percentage_until_max"] as! Int
                    self.shotsLabel.text = String(currData["servings_left_until_max"] as! Int)
                    self.updateProgressBar()
                }
        }
    }
    
    func updateProgressBar() {
        let screenHeight = SCREEN_HEIGHT - labelView.frame.size.height
        
        let yOrigin = (screenHeight * CGFloat(occassion.percentageMax))/100
        if occassion.percentageMax < 33 {
            progressView.backgroundColor = UIColor.greenColor()
        } else if occassion.percentageMax < 66 {
            progressView.backgroundColor = UIColor.yellowColor()
        } else {
            progressView.backgroundColor = UIColor.redColor()
        }
        var realY = SCREEN_HEIGHT - yOrigin
        if occassion.servingsLeft == 0 {
            realY = 0
            let alert = UIAlertController(title: "Warning", message: "You already reached your maximum alcohol intake.", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
        progressView.frame = CGRect(x: 0, y: realY, width: SCREEN_WIDTH, height: SCREEN_HEIGHT)
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == UIEventSubtype.MotionShake {
            //end session
            let alert = UIAlertController(title: "End Session", message: "Are you sure you want to end tracking your drinks?", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "YES", style: .Default)  { action in
                self.endSession()
            })
            alert.addAction(UIAlertAction(title: "No", style: .Cancel, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func endSession() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var rootViewController:UIViewController!
        rootViewController = storyboard.instantiateViewControllerWithIdentifier("occassionTable") as UIViewController
        let navController = UINavigationController(rootViewController: rootViewController)
        presentViewController(navController, animated: true, completion: nil)
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
