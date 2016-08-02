//
//  JSONManager.swift
//  SmartTips
//
//  Created by Christopher Bonuel on 8/1/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import Alamofire
import SwiftyJSON

class SmartTipJSONManager {
    
    var json: JSON = JSON([])
    var smartTips = [SmartTip]()
    
    func loadArrayFromJSONurl(url: URLStringConvertible, completionHandler: () -> ()) {
        
        Alamofire.request(.GET, url).responseJSON { response in
            
            switch response.result {
            case .Success(let value): self.json = JSON(value)
            case .Failure(let error): print(error)
            }
            self.parseJSON()
            completionHandler()
        }
    }
    
    func parseJSON() {
        smartTips = json[dataPath].arrayValue.flatMap { SmartTip(smartTip: $0) }
        smartTips.sortInPlace()
    }
}