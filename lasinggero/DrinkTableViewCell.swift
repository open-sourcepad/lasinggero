//
//  DrinkTableViewCell.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {

    @IBOutlet var drinkCount: UITextField!
    @IBOutlet var drinkLabel: UILabel!
    
    var drink = Drink()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDrinkData(drinkData: Drink) {
        drink = drinkData
        drink.drinkCounted = drink.drinkCounted
        drinkCount?.text = String(drink.drinkCount)
        drinkLabel?.text = "\(drink.drinkName) - \(drink.drinkServingType)(\(Int(drink.drinkSize)) ml)"
    }

    @IBAction func minusBtnClicked(sender: AnyObject) {
        drink.drinkCounted =  drink.drinkCounted - 1
        drinkCount.text = String(drink.drinkCounted )
    }
    @IBAction func addBtnClicked(sender: AnyObject) {
        drink.drinkCounted =  drink.drinkCounted + 1
        drinkCount.text = String(drink.drinkCounted )    }
}
