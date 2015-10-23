//
//  Font.swift
//  lasinggero
//
//  Created by Marvin Allan Lu on 24/10/2015.
//  Copyright © 2015 ruthg. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    var substituteFontName : String {
        get { return self.font.fontName }
        set { self.font = UIFont(name: newValue, size: self.font.pointSize) }
    }
    
}