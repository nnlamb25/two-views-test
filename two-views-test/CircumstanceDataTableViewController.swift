//
//  CircumstanceDataTableViewController.swift
//  two-views-test
//
//  Created by Nathan Lamb on 5/13/19.
//  Copyright © 2019 Factual, Inc. All rights reserved.
//

import FactualEngine
import Foundation
import UIKit

class CircumstanceDataTableViewController: UITableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Circumstance Cell")
        guard indexPath.row < ActionDelegate.circumstanceData.count else { return cell }
        let data = ActionDelegate.circumstanceData[indexPath.row]
        let labelHeight = heightForView(text: data)
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: labelHeight))
        label.contentMode = .scaleToFill
        label.numberOfLines = 0
        label.text = data
        cell.addSubview(label)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ActionDelegate.circumstanceData.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row < ActionDelegate.circumstanceData.count else { return 50 }
        return heightForView(text: ActionDelegate.circumstanceData[indexPath.row])
    }
    
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
}