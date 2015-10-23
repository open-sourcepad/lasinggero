//
//  BenchMark.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit

class BenchMark: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var drink = Drink()
    var drinkLabel: UILabel!
    var drinkCount: UITextField!
    var customStepper: UIStepper!
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        
        drinkLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_CENTER_X - 50, height: 60.0))
        drinkCount = UITextField(frame: CGRect(x: SCREEN_CENTER_X + 30, y: 0, width: SCREEN_CENTER_X - 50, height: 60.0))
        
        customStepper = UIStepper (frame:CGRectMake(0, 70, 0, 0))
        customStepper.wraps = true
        customStepper.autorepeat = true
        customStepper.minimumValue = 0
        customStepper.addTarget(self, action: "stepperValueChanged:", forControlEvents: .ValueChanged)
        self.addSubview(customStepper)
    }
    
    func stepperValueChanged(sender:UIStepper!) {
        drinkCount.text = String(sender.value)
    }
    
    func setCurrentDrink(currentDrink: Drink) {
        drink = currentDrink
        customStepper.value = drink.drinkCount
        drinkLabel.text = drink.drinkName
        drinkCount.text = String(drink.drinkCount)
    }
    
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

}
