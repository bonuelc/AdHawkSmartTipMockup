//
//  SmartTipViewController.swift
//  SmartTips
//
//  Created by Christopher Bonuel on 7/28/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol SmartTipDelegate {
    func tipStatusSelectionDidFinish(controller: SmartTipViewController)
}

class SmartTipViewController: UIViewController {
    
    @IBOutlet weak var providerLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var rejectButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    var data: JSON = JSON([])
    var statusPicked: Status = .Read
    var delegate: SmartTipDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureLabels()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func rejectButtonTapped() {
        statusPicked = .Rejected
        configureButtons()
    }
    
    @IBAction func acceptButtonTapped() {
        statusPicked = .Accepted
        configureButtons()
    }
    
    @IBAction func cancelButtonTapped() {
        statusPicked = .Read
        configureButtons()
    }
    
    @IBAction func okButtonTapped() {
        updateData()
        delegate.tipStatusSelectionDidFinish(self)
    }
    
    func updateData() {
        data["attributes"]["status"].int = statusPicked.rawValue
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
    
    func configureButtons() {
        
        switch statusPicked {
        case .Accepted, .Rejected:
            rejectButton.hidden = true
            acceptButton.hidden = true
            okButton.hidden = false
            cancelButton.hidden = false
        default:
            rejectButton.hidden = false
            acceptButton.hidden = false
            okButton.hidden = true
            cancelButton.hidden = true
        }
    }
}