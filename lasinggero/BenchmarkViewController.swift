//
//  BenchmarkViewController.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit
import Alamofire

class BenchmarkViewController: UIViewController {
    @IBOutlet var benchmarkView: UIView!
    var drinks = [Drink]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var yOrigin:CGFloat = 20.0
        for drink in drinks {

            let drinkView = BenchMark.init(frame: CGRect(x: 10.0, y: yOrigin, width: SCREEN_CENTER_X - 50, height: 60.0))
            drinkView.setCurrentDrink(drink)
            yOrigin = yOrigin + 60.0 + 5

            benchmarkView.addSubview(drinkView)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        drinksList()
    }
    
    func drinksList() {
        let manager = Alamofire.Manager.sharedInstance
        manager.request(.GET, BENCHMARK_API)
            .responseJSON { response in
                debugPrint(response)
                if response.result.error == nil {
                    debugPrint(response.result.value)
                    var data = response.result.value as! NSDictionary
                } else {
                    let drink1 = Drink()
                    drink1.drinkName = "JD"
                    let drink2 = Drink()
                    drink2.drinkName = "SMB"
                    drinks = [drink1, drink2]
                }
        }
    }
    
    @IBAction func submitBenchmark(sender: AnyObject) {
        
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
