//
//  EngineDelegate.swift
//  two-views-test
//
//  Created by Nathan Lamb on 5/13/19.
//  Copyright © 2019 Factual, Inc. All rights reserved.
//

import FactualEngine
import Foundation

class EngineDelegate: FactualEngineDelegate {
    
    func engineDidStart(withInstance engine: FactualEngine) {
        print("Engine started")
        AppDelegate.engine = engine
        engine.registerAction(withId: "test-action", listener: ActionDelegate())
    }
    
    func engineDidStop() {
        print("Engine stopped")
        AppDelegate.engine = nil
    }
    
    func engineDidFailWithError(_ factualError: FactualError) {
        print("Engine failed with error: \(factualError.message)")
    }
    
    func engineDidReportInfo(_ infoMessage: String) {
        print("Engine reported info: \(infoMessage)")
    }
    
    func engineDidSyncWithGarage() {
        print("Engine synced with garage")
    }
    
    func engineDidLoadConfig(_ data: FactualConfigMetadata) {
        print("Engine loaded config with data: \(data.toDict())")
    }
    
    func engineDidReportDiagnosticMessage(_ diagnosticMessage: String) {
        print("Eninge diagnostic message: \(diagnosticMessage)")
    }
    
    
}
