//
//  ViewController.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var logoView: UIView!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var emailFld: UITextField!
    @IBOutlet weak var passwordFld: UITextField!
    @IBOutlet weak var signInView: UIView!
    
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signUpEmailFld: UITextField!
    @IBOutlet weak var nameFld: UITextField!
    @IBOutlet weak var weightFld: UITextField!
    @IBOutlet weak var ageFld: UITextField!
    @IBOutlet weak var signUpSubmit: UIButton!
    @IBOutlet weak var signUpPasswordFld: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        signUpView.hidden = true
        signInView.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        NSLog("test")
        for currView in view.subviews {
            if currView.isKindOfClass(UIView) {
                for childView in currView.subviews {
                    if childView.isFirstResponder() {
                        childView.resignFirstResponder()
                    }
                }
            } else {
                if currView.isFirstResponder() {
                    currView.resignFirstResponder()
                }
            }
        }
    }
    
    
    @IBAction func signInUser(sender: AnyObject) {
        
    }
    
    @IBAction func signUpUser(sender: AnyObject) {
        guard validFields() else { return }
        
        let params = [ "user": ["name": "\(nameFld.text)",
            "email":  "\(signUpEmailFld.text)",
            "password":  "\(signUpPasswordFld.text)",
            "device_token":  "\(DEVICE_ID)"]]
        
        let manager = Alamofire.Manager.sharedInstance
        NSLog("\(params)")
        manager.request(.POST, SIGN_UP_URL, parameters: params)
            .responseJSON { response in
                if (response.result.error != nil) {
                    
                } else {
                    debugPrint(response)
                    let userData = response.result.value as! NSDictionary
                    let mainData = userData.objectForKey("data") as! NSDictionary
                    let user = User()
                    user.authToken = mainData.objectForKey("authentication_token") as! String
                    user.name = mainData.objectForKey("name") as! String
                    user.email = mainData.objectForKey("email") as! String
                    NSUserDefaults.standardUserDefaults().setObject(user.authToken, forKey: "authToken")
                    let storyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    var rootViewController:UIViewController!
                    rootViewController = storyboard.instantiateViewControllerWithIdentifier("benchmarkView") as UIViewController
                    let navController  = UINavigationController(rootViewController: rootViewController)
                    self.presentViewController(navController, animated: true, completion: nil)
                }
        }
        
    }

    @IBAction func showSignIn(sender: AnyObject) {
        signUpView.hidden = true
        signInView.hidden = false
    }

    @IBAction func showSignUp(sender: AnyObject) {
        signUpView.hidden = false
        signInView.hidden = true
    }
    
    func validFields() -> Bool {
        if nameFld.text == "" || signUpEmailFld.text == "" || signUpPasswordFld == "" {
            let alert = UIAlertController(title: "Error", message: "Fill out required fields", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(alert, animated: true, completion: nil)
            return false
        }
        return true
    }
}

