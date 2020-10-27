//
//  TourDeForceApp.swift
//  TourDeForce
//
//  Created by Tor1 on 2020-10-27.
//

import SwiftUI

@main
struct TourDeForceApp: App {
    @StateObject var dataController: DataController
    
    init() {
        let dataController = DataController()
        _dataController = StateObject(wrappedValue: dataController)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
        }
    }
}
