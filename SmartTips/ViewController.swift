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

    var json: JSON = JSON([]) {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJSON()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSmartTipDetailView" {
            if let tipVC = segue.destinationViewController as? SmartTipViewController, index = tableView.indexPathForSelectedRow?.row {
                tipVC.data = json["data"][index]
                tipVC.delegate = self
            }
        }
    }

    func getJSON() {
        
        Alamofire.request(.GET, "https://demo7998593.mockable.io/smarttips.json").responseJSON { response in
            
            switch response.result {
            case .Success(let value): self.json = JSON(value)
            case .Failure(let error): print(error)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return json["data"].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        guard let cell: TipTableViewCell = tableView.dequeueReusableCellWithIdentifier("tipCell") as? TipTableViewCell else {
            return UITableViewCell()
        }
        
        if let provider = json["data"][indexPath.row]["relationships"]["identity"]["data"]["provider"].string {
            cell.providerLabel.text = provider
        }
        
        if let title = json["data"][indexPath.row]["attributes"]["title"].string {
            cell.titleLabel.text = title
        }
        
        if let description = json["data"][indexPath.row]["attributes"]["description"].string {
            cell.descriptionLabel.text = description
        }
        
        if let status = Status(rawValue: json["data"][indexPath.row]["attributes"]["status"].int!) {
            switch status {
            case .Accepted: cell.backgroundColor = SmartTipColor.greenColor()
            case .Rejected: cell.backgroundColor = SmartTipColor.redColor()
            default: break
            }
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let reject = UITableViewRowAction(style: .Destructive, title: "Reject") { (action, indexPath) in
            self.json["data"][indexPath.row]["attributes"]["status"].int = Status.Rejected.rawValue
        }
        
        let accept = UITableViewRowAction(style: .Normal, title: "Accept") { (action, indexPath) in
            self.json["data"][indexPath.row]["attributes"]["status"].int = Status.Accepted.rawValue
        }
        
        reject.backgroundColor = SmartTipColor.redColor()
        accept.backgroundColor = SmartTipColor.greenColor()
        
        return [reject, accept]
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            
        guard let cell: TipTableViewCell = tableView.dequeueReusableCellWithIdentifier("tipCell") as? TipTableViewCell else {
            return UITableViewCell().bounds.size.height
        }
        
        return cell.bounds.size.height
    }
}

extension ViewController: SmartTipDelegate {
    func tipStatusSelectionDidFinish(controller: SmartTipViewController) {
        controller.dismissViewControllerAnimated(true) { () in
            if let index = self.tableView.indexPathForSelectedRow?.row {
                self.json["data"][index] = controller.data
            }
        }
    }
}