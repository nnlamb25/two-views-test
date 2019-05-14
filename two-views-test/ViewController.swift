//
//  ViewController.swift
//  two-views-test
//
//  Created by Nathan Lamb on 5/13/19.
//  Copyright © 2019 Factual, Inc. All rights reserved.
//

import CoreLocation
import FactualEngine
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var testCircumstanceButton: UIButton!
    
    var locations = ["Dodger Stadium": CLLocation(latitude: 34.0739, longitude: -118.2400),
                     "LA Coliseum": CLLocation(latitude: 34.0141, longitude: -118.2879),
                     "Staples Center": CLLocation(latitude: 34.0430, longitude: -118.2673),
                     "PNC Park": CLLocation(latitude: 40.4469, longitude: -80.0057)]

    @IBAction func testCircumstance(_ sender: UIButton) {
        let index = locations.index(locations.startIndex, offsetBy: Int.random(in: 0..<locations.count))
        let randomLocation = locations[index]
        print("Running circumstance at \(randomLocation.key)")
        AppDelegate.engine?.runCircumstances(withMockLocation: randomLocation.value)
    }
}
