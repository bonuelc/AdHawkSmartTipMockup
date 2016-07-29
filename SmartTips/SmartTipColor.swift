//
//  SmartTipColor.swift
//  SmartTips
//
//  Created by Christopher Bonuel on 7/29/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit

class SmartTipColor {
    
    private init() {}
    
    class func greenColor() -> UIColor {
        return UIColor.init(red: 46.0/255.0, green: 224.0/255.0, blue: 136.0/255.0, alpha: 1.0)
    }
    
    class func redColor() -> UIColor {
        return UIColor.init(red: 237.0/255.0, green: 29.0/255.0, blue: 35.0/255.0, alpha: 1.0)
    }
    
    class func grayColor() -> UIColor {
        return UIColor.init(red: 144.0/255.0, green: 144.0/255.0, blue: 146.0/255.0, alpha: 1.0)
    }
}