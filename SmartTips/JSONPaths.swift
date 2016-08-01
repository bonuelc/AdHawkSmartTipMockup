//
//  JSONPaths.swift
//  SmartTips
//
//  Created by Christopher Bonuel on 7/29/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import SwiftyJSON

let arrayPath: [JSONSubscriptType] = ["data"]
let providerPath: [JSONSubscriptType] = ["relationships", "identity", "data", "provider"]
let titlePath: [JSONSubscriptType] = ["attributes", "title"]
let descriptionPath: [JSONSubscriptType] = ["attributes", "description"]
let statusPath: [JSONSubscriptType] = ["attributes", "status"]
let expiresAtDatePath: [JSONSubscriptType] = ["attributes", "expires_at"]
let createdAtDatePath: [JSONSubscriptType] = ["attributes", "created_at"]