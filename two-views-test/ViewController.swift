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
    
    // Random Locations which trigger the circumstance
    var locations = ["Dodger Stadium": CLLocation(latitude: 34.0739, longitude: -118.2400),
                     "LA Coliseum": CLLocation(latitude: 34.0141, longitude: -118.2879),
                     "Staples Center": CLLocation(latitude: 34.0430, longitude: -118.2673),
                     "PNC Park": CLLocation(latitude: 40.4469, longitude: -80.0057)]

    // Triggers a circumstance for a random location after a 3 second delay
    @IBAction func testCircumstance(_ sender: UIButton) {
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            guard FactualEngine.isEngineStarted() else { print("Engine not yet started"); return }
            
            let rand = Int.random(in: 0..<self.locations.count)
            let index = self.locations.index(self.locations.startIndex, offsetBy: rand)
            let randomLocation = self.locations[index]
            
            print("Running circumstance at \(randomLocation.key)")
            AppDelegate.engine?.runCircumstances(withMockLocation: randomLocation.value)
        }
    }
}
