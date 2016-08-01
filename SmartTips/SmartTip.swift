//
//  SmartTip.swift
//  SmartTips
//
//  Created by Christopher Bonuel on 8/1/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import Foundation
import SwiftyJSON

struct SmartTip {
    let provider: String
    let title: String
    let description: String
    var status: Status
    let creationDate: NSDate
    var expired: Bool = false
    
    init?(smartTip: JSON) {
        guard let p = smartTip[providerPath].string else {
            return nil
        }
        
        guard let t = smartTip[titlePath].string else {
            return nil
        }
        
        guard let d = smartTip[descriptionPath].string else {
            return nil
        }
        
        guard let statusInt = smartTip[statusPath].int, s = Status(rawValue: statusInt) else {
            return nil
        }
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        if let dateString = smartTip[createdAtDatePath].string, cDate = formatter.dateFromString(dateString) {
            creationDate = cDate
        } else {
            creationDate = NSDate()
        }
        
        // commented out b/c all sample data are expired
        //        if let dateString = smartTip[expiresAtDatePath].string, expirationDate = formatter.dateFromString(dateString) {
        //            if expirationDate < NSDate() { return nil }
        //        }
        
        provider = p
        title = t
        description = d
        status = s
    }
    
    mutating func reject() {
        status = Status.Rejected
    }
    
    mutating func accept() {
        status = Status.Accepted
    }
}

extension SmartTip: Equatable, Comparable {
}

func ==(lhs: SmartTip, rhs: SmartTip) -> Bool {
    return lhs.creationDate == rhs.creationDate
}

func <(lhs: SmartTip, rhs: SmartTip) -> Bool {
    return lhs.creationDate < rhs.creationDate
}

extension NSDate: Comparable {
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}