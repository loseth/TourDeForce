//
//  TourDeForceApp.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-10-27.
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
                // Automatically save when we detect that we are no longer
                // the forground app. Use this rather than the scene phase
                // API so we can port to macOS, where scene phase won't detect
                // our app losing focus as of macOS 11.1.
                .onReceive(
                    NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
                    perform: save)
        }
    }

    func save(_ note: Notification) {
        dataController.save()
    }
}
