//
//  ViewController.swift
//  SmartTips
//
//  Created by Christopher Bonuel on 7/26/16.
//  Copyright © 2016 Christopher Bonuel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentfier = "smartTipCell"
    let jsonURL: URLStringConvertible = "https://demo7998593.mockable.io/smarttips.json"
    
    var smartTips: [SmartTip] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let smartTipManager = SmartTipJSONManager()
        smartTipManager.loadArrayFromJSONurl(jsonURL)
        smartTips = smartTipManager.smartTips
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSmartTipDetailView" {
            if let tipVC = segue.destinationViewController as? SmartTipViewController, index = tableView.indexPathForSelectedRow?.row {
                tipVC.smartTip = smartTips[index]
                tipVC.delegate = self
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smartTips.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell: SmartTipTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentfier) as? SmartTipTableViewCell else {
            return UITableViewCell()
        }
        
        let smartTip = smartTips[indexPath.row]
        
        cell.providerLabel.text = smartTip.provider
        cell.titleLabel.text = smartTip.title
        cell.descriptionLabel.text = smartTip.description
        
        switch smartTip.status {
        case .Accepted: cell.backgroundColor = SmartTipColor.greenColor()
        case .Rejected: cell.backgroundColor = SmartTipColor.redColor()
        default: cell.backgroundColor = UIColor.whiteColor()
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let reject = UITableViewRowAction(style: .Destructive, title: "Reject") { (action, indexPath) in
            self.smartTips[indexPath.row].reject()
        }
        
        let accept = UITableViewRowAction(style: .Normal, title: "Accept") { (action, indexPath) in
            self.smartTips[indexPath.row].accept()
        }
        
        reject.backgroundColor = SmartTipColor.redColor()
        accept.backgroundColor = SmartTipColor.greenColor()
        
        return [reject, accept]
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            
        guard let cell: SmartTipTableViewCell = tableView.dequeueReusableCellWithIdentifier(cellIdentfier) as? SmartTipTableViewCell else {
            return UITableViewCell().bounds.size.height
        }
        
        return cell.bounds.size.height
    }
}

extension ViewController: SmartTipDelegate {
    func tipStatusSelectionDidFinish(controller: SmartTipViewController) {
        controller.dismissViewControllerAnimated(true) { () in
            if let index = self.tableView.indexPathForSelectedRow?.row {
                self.smartTips[index] = controller.smartTip
            }
        }
    }
}