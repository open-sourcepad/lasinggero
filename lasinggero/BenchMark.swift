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
    var addBtn: UIButton!
    var minusBtn: UIButton!
    
     override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func addBtnClicked() {
        drinkCount.text = String(Int(drinkCount.text!)! + 1)
    }
    
    func minusBtnClicked() {
        if drink.drinkCounted > 0 {
            drinkCount.text = String(Int(drinkCount.text!)! - 1)
        }
    }
    
    func setCurrentDrink(currentDrink: Drink) {
        drink = currentDrink
        let stepBtnWidth:CGFloat = 30.0
        minusBtn = UIButton(frame: CGRect(x: SCREEN_WIDTH - CGFloat(5.0) - stepBtnWidth, y: 0, width: stepBtnWidth, height: stepBtnWidth))
        minusBtn.setTitle("-", forState: .Normal)
        minusBtn.addTarget(self, action: "minusBtnClicked", forControlEvents: .TouchUpInside)
        minusBtn.backgroundColor = UIColor.blackColor()
        minusBtn.userInteractionEnabled = true
        drinkLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_CENTER_X - 50, height: 60.0))
        drinkCount = UITextField(frame: CGRect(x: minusBtn.frame.origin.x - minusBtn.frame.size.width, y: 0, width: SCREEN_CENTER_X - 50, height: 60.0))
        addBtn = UIButton(frame: CGRect(x: drinkCount.frame.origin.x - drinkCount.frame.size.width , y: 0, width: stepBtnWidth, height: stepBtnWidth))
        addBtn.setTitle("+", forState: .Normal)
        addBtn.userInteractionEnabled = true
        addBtn.addTarget(self, action: "addBtnClicked", forControlEvents: .TouchUpInside)
        addBtn.backgroundColor = UIColor.blackColor()
        drinkLabel.text = "\(drink.drinkName) - \(drink.drinkServingType) - \(drink.drinkSize)"
        drinkCount.text = String(drink.drinkCount)
        
        self.addSubview(drinkLabel)
        self.addSubview(minusBtn)
        self.addSubview(drinkCount)
        self.addSubview(addBtn)
        
    }
    
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

}
