//
//  BenchmarkViewController.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit
import Alamofire

class BenchmarkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet var benchmarkView: UIView!
    @IBOutlet weak var drinksTable: UITableView!
    
    var drinks:NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        drinksTable.registerNib(UINib(nibName: "DrinkCell", bundle: nil), forCellReuseIdentifier: "DrinkCell")        
//        drinksTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "DrinkCell")
        drinksTable.delegate = self
        drinksTable.dataSource = self
        drinksList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func loadDrinks() {
//        var yOrigin:CGFloat = 20.0
//        for drink in drinks {
//            
//            let drinkView = BenchMark.init(frame: CGRect(x: 10.0, y: yOrigin, width: SCREEN_CENTER_X - 50, height: 60.0))
//            drinkView.setCurrentDrink(drink as! Drink)
//            yOrigin = yOrigin + 80 + 5
//            
//            benchmarkView.addSubview(drinkView)
//        }
//
//    }
    
    func drinksList() {
        let manager = Alamofire.Manager.sharedInstance
        let authToken = NSUserDefaults.standardUserDefaults().objectForKey("authToken") as! String
        let params = ["authentication_token": "\(authToken)"]
        manager.request(.GET, BENCHMARK_API, parameters: params)
            .responseJSON { response in
                debugPrint(response)
                if response.result.error == nil {
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
                        self.drinks.addObject(drinkCat)
                        AppDelegate().drinksItems.addObject(drinkCat)

                    }
                }
                self.drinksTable.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = drinksTable.dequeueReusableCellWithIdentifier("DrinkCell", forIndexPath: indexPath) as! DrinkTableViewCell
        let currDrink = drinks[indexPath.row] as! Drink
        cell.setDrinkData(currDrink)
//        cell.textLabel?.text = currDrink.drinkName
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func submitBenchmark(sender: AnyObject) {
        let authToken = NSUserDefaults.standardUserDefaults().objectForKey("authToken") as! String
        let drinksParam:NSMutableArray = []
        
        for drinkI  in drinks{
            let drinkAs = drinkI as! Drink
            drinksParam.addObject(["drink_id": "\(drinkAs.drinkId)", "quantity": drinkAs.drinkCounted])
        }
        
        let params = [ "authentication_token": "\(authToken)", "drink_benchmarks": drinksParam]
        
        Alamofire.Manager.sharedInstance.request(.POST, BENCHMARK_API, parameters: params)
            .responseJSON {response in
                debugPrint(response)
                if response.result.error == nil {
                    let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let occassionTable = storyboard.instantiateViewControllerWithIdentifier("occassionTable") as! OccassionTableViewController
                    let navController = UINavigationController(rootViewController: occassionTable)
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
