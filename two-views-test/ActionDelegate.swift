//
//  CircumstanceDataActionDelegate.swift
//  two-views-test
//
//  Created by Nathan Lamb on 5/13/19.
//  Copyright © 2019 Factual, Inc. All rights reserved.
//

import FactualEngine
import Foundation

class ActionDelegate: FactualActionDelegate {
    
    private enum DataType {
        case circumstance
        case place
    }
    
    static var circumstanceData = [String]()
    static var placeData = [String]()
    
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
    
    func circumstancesDidOccur(_ circumstances: [CircumstanceResponse]) {
        for circumstanceResponse in circumstances {
            let circumstance = circumstanceResponse.circumstance
            let entryNumber = nextEntryNumber(.circumstance)
            let circumstanceData = "\(entryNumber): \nName: \(circumstance.name)\nCircumstance ID: \(circumstance.circumstanceId)\nAction ID: \(circumstance.actionId)"
            ActionDelegate.circumstanceData.append(circumstanceData)
        }
        
        guard let place = circumstances.first?.atPlaces?.first else { return }
        let entryNumber = nextEntryNumber(.place)
        let placeData = "\(entryNumber): \nName: \(place.name)\nLatitude: \(place.latitude)\nLongitude: \(place.longitude)\nFactual ID: \(place.factualId)"
        ActionDelegate.placeData.append(placeData)
    }
    
    func circumstance(_ circumstance: FactualCircumstance, didFailWithError error: FactualError) {
        ActionDelegate.circumstanceData.append("\(nextEntryNumber(.circumstance)): \(error.message)")
        ActionDelegate.placeData.append("\(nextEntryNumber(.place)): \(error.message)")
    }
}
