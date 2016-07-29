//
//  SmartTipViewController.swift
//  SmartTips
//
//  Created by Christopher Bonuel on 7/28/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit
import SwiftyJSON

class SmartTipViewController: UIViewController {
    
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var data: JSON = JSON([])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureLabels()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureLabels() {
        
        if let provider = data["relationships"]["identity"]["data"]["provider"].string {
            providerLabel.text = provider
        }
        
        if let title = data["attributes"]["title"].string {
            titleLabel.text = title
        }
        
        if let description = data["attributes"]["description"].string {
            descriptionLabel.text = description
        }
    }
}
