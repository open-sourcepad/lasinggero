//
//  Constants.swift
//  lasinggero
//
//  Created by Ruth Gares on 10/23/15.
//  Copyright © 2015 ruthg. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_HEIGHT_6       =         667.0   // iPhone 6
let SCREEN_HEIGHT_5       =         568.0   // iPhone 5
let SCREEN_HEIGHT_4       =         480.0   // iPhone 4/4S
let IS_IOS8_ABOVE           =          ((UIDevice.currentDevice().systemVersion as NSString).floatValue >= 8.0)
let IS_IPHONE_6                =         Double(UIScreen.mainScreen().bounds.size.height) == SCREEN_HEIGHT_6
let IS_IPHONE_5                =         Double(UIScreen.mainScreen().bounds.size.height) == SCREEN_HEIGHT_5
let IS_IPHONE_4                =         Double(UIScreen.mainScreen().bounds.size.height) ==  SCREEN_HEIGHT_4
let IS_IPHONE_4S_IOS8   =         !IS_IPHONE_5 && IS_IOS8_ABOVE
let IS_RETINA                     =         UIScreen.mainScreen().scale == 2.0
let SCREEN_WIDTH:CGFloat              =         UIScreen.mainScreen().bounds.size.width
let SCREEN_HEIGHT:CGFloat             =         UIScreen.mainScreen().bounds.size.height
let SCREEN_CENTER_X:CGFloat         =         SCREEN_WIDTH / 2
let SCREEN_CENTER_Y:CGFloat         =        SCREEN_HEIGHT / 2

//API URL
let API_BASE_URL  =  "https://lasinggero.herokuapp.com/"
let SIGN_UP_URL = "https://lasinggero.herokuapp.com/api/users/sign_up"
let BENCHMARK_API = "https://lasinggero.herokuapp.com/api/drink_benchmarks"
let OCCASSION_API = "https://lasinggero.herokuapp.com/api/occasions"
let DRINK_API = "https://lasinggero.herokuapp.com/api/occasion/:id/occasion_drink"

let DEVICE_ID = UIDevice.currentDevice().identifierForVendor!.UUIDString

