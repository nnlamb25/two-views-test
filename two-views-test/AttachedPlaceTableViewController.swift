//
//  AttachedPlaceTableViewController.swift
//  two-views-test
//
//  Created by Nathan Lamb on 5/13/19.
//  Copyright © 2019 Factual, Inc. All rights reserved.
//

import FactualEngine
import Foundation
import NotificationCenter
import UIKit

class AttachedPlaceTableViewController: UITableViewController {
    
    // Adds an observer to refresh the table view data
    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(refreshTable),
                                       name: ActionDelegate.newDataNotification,
                                       object: nil)
    }
    
    // Generates a cell from circumstance data in ActionDelegate
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Place Cell")
        guard indexPath.row < ActionDelegate.placeData.count else { return cell }
        let data = ActionDelegate.placeData[indexPath.row]
        let labelHeight = heightForView(text: data)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: labelHeight))
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.text = data
        cell.addSubview(label)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ActionDelegate.placeData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row < ActionDelegate.placeData.count else { return 50 }
        return heightForView(text: ActionDelegate.placeData[indexPath.row])
    }
    
    // Returns the height of a table view cell based on how much text it holds.
    private func heightForView(text:String) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0,
                                                  y: 0,
                                                  width: UIScreen.main.bounds.width,
                                                  height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    // Refreshes data everytime a circumstance is met
    @objc private func refreshTable() {
        self.tableView.reloadData()
    }
}

