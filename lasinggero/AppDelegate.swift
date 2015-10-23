//
//  AppDelegate.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var currentUser: User!
    var drinksItems:NSMutableArray = []
    var currOccassion: Occassion!
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
       
        let userDefault = NSUserDefaults.standardUserDefaults()
        if (userDefault.objectForKey("authToken") != nil) {
            populateList()
            goToLandingScreen()
        } else {
            goToLogIn()
        }
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func goToLogIn() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var rootViewController:UIViewController!
        rootViewController = storyboard.instantiateViewControllerWithIdentifier("logView") as UIViewController
        window?.rootViewController = rootViewController        
    }
    
    func goToLandingScreen() {
        let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var rootViewController:UIViewController!
        rootViewController = storyboard.instantiateViewControllerWithIdentifier("occassionTable") as UIViewController
        let navController = UINavigationController(rootViewController: rootViewController)
        window?.rootViewController = navController
    }
    
    func populateList() {
        let manager = Alamofire.Manager.sharedInstance
        let authToken = NSUserDefaults.standardUserDefaults().objectForKey("authToken") as! String
        let params = ["authentication_token": "\(authToken)"]
        manager.request(.GET, BENCHMARK_API, parameters: params)
            .responseJSON { response in
                debugPrint(response)
                if response.result.error == nil {
                    self.drinksItems = []
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
                        self.drinksItems.addObject(drinkCat)
                    }
                }
        }
    }


}
