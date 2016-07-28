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
        // Do any additional setup after loading the view, typically from a nib.
        getJSON()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        if let status = json["data"][indexPath.row]["attributes"]["status"].int {
            if status == 2 {
                cell.backgroundColor = UIColor.greenColor()
            } else if status == 3 {
                cell.backgroundColor = UIColor.redColor()
            }
        }
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let reject = UITableViewRowAction(style: .Destructive, title: "Reject") { (action, indexPath) in
            self.json["data"][indexPath.row]["attributes"]["status"].int = 3
        }
        
        let accept = UITableViewRowAction(style: .Normal, title: "Accept") { (action, indexPath) in
            self.json["data"][indexPath.row]["attributes"]["status"].int = 2
        }
        
        accept.backgroundColor = UIColor.greenColor()
        
        return [reject, accept]
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            
        guard let cell: TipTableViewCell = tableView.dequeueReusableCellWithIdentifier("tipCell") as? TipTableViewCell else {
            return UITableViewCell().bounds.size.height
        }
        
        return cell.bounds.size.height
    }
}