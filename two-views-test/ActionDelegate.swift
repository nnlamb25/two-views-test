//
//  CircumstanceDataActionDelegate.swift
//  two-views-test
//
//  Created by Nathan Lamb on 5/13/19.
//  Copyright © 2019 Factual, Inc. All rights reserved.
//

import FactualEngine
import Foundation
import NotificationCenter

// Singleton Factual Action Delegate
class ActionDelegate: FactualActionDelegate {
    
    // Types of data we are looking for
    private enum DataType {
        case circumstance
        case place
    }
    
    // Arrays referenced outside of the ActionDelegate
    static var circumstanceData = [String]()
    static var placeData = [String]()
    
    // Notification Name for when a circumstance is met
    static var newDataNotification = NSNotification.Name(rawValue: "refresh")
    
    // Grabs some data from the circumstance response and adds it to the arrays
    func circumstancesDidOccur(_ circumstances: [CircumstanceResponse]) {
        for circumstanceResponse in circumstances {
            let entryNumber = nextEntryNumber(.circumstance)
            let name = circumstanceResponse.circumstance.name
            let circumstanceId = circumstanceResponse.circumstance.circumstanceId
            let actionId = circumstanceResponse.circumstance.actionId
            let circumstanceData = "\(entryNumber): \nName: \(name)\nCircumstance ID: \(circumstanceId)\nAction ID: \(actionId)"
            ActionDelegate.circumstanceData.append(circumstanceData)
        }
        
        guard let place = circumstances.first?.atPlaces?.first else { return }
        let entryNumber = nextEntryNumber(.place)
        let placeData = "\(entryNumber): \nName: \(place.name)\nLatitude: \(place.latitude)\nLongitude: \(place.longitude)\nFactual ID: \(place.factualId)"
        ActionDelegate.placeData.append(placeData)
        NotificationCenter.default.post(name: ActionDelegate.newDataNotification, object: nil)
    }
    
    // Logs an error to both arrays
    func circumstance(_ circumstance: FactualCircumstance, didFailWithError error: FactualError) {
        ActionDelegate.circumstanceData.append("\(nextEntryNumber(.circumstance)): \(error.message)")
        ActionDelegate.placeData.append("\(nextEntryNumber(.place)): \(error.message)")
        NotificationCenter.default.post(name: ActionDelegate.newDataNotification, object: nil)
    }
    
    // Gets the next entry number from the previous one
    private func nextEntryNumber(_ dataType: DataType) -> Int {
        var data = [String]()
        switch dataType {
        case .circumstance:
            data = ActionDelegate.circumstanceData
        case .place:
            data = ActionDelegate.placeData
        }
        guard
            let lastDataPoint = data.last,
            let entry = lastDataPoint.components(separatedBy: ":").first,
            let entryNumber = Int(entry)
            else { return 1 }
        return entryNumber + 1
    }
}
