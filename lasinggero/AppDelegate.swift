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
    var currOccassion: Occassion!
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 52.0/255.0, green: 52.0/255.0, blue: 59.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        UILabel.appearance().substituteFontName = "Avenir"
        let userDefault = NSUserDefaults.standardUserDefaults()
        if (userDefault.objectForKey("authToken") != nil) {
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

}
