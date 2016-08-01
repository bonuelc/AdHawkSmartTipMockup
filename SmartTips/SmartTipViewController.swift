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
    
    var smartTip: SmartTip!
    var delegate: SmartTipDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabels()
    }
    
    @IBAction func rejectButtonTapped() {
        smartTip.reject()
        configureButtons()
    }
    
    @IBAction func acceptButtonTapped() {
        smartTip.accept()
        configureButtons()
    }
    
    @IBAction func cancelButtonTapped() {
        smartTip.read()
        configureButtons()
    }
    
    @IBAction func okButtonTapped() {
        delegate.tipStatusSelectionDidFinish(self)
    }
    
    func configureLabels() {
        providerLabel.text = smartTip.provider
        titleLabel.text = smartTip.title
        descriptionLabel.text = smartTip.description
    }
    
    func configureButtons() {
        
        switch smartTip.status {
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