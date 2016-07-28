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
        
        guard let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("tipCell") else {
            return UITableViewCell()
        }
        
        
        if let title = json["data"][indexPath.row]["attributes"]["title"].string {
            cell.textLabel?.text = title
        }
        
        if let description = json["data"][indexPath.row]["attributes"]["description"].string {
            cell.detailTextLabel?.text = description
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