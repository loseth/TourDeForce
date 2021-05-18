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
    @StateObject var unlockManager: UnlockManager

    init() {
        let dataController = DataController()
        let unlockManager = UnlockManager(dataController: dataController)

        _dataController = StateObject(wrappedValue: dataController)
        _unlockManager = StateObject(wrappedValue: unlockManager)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(dataController)
                .environmentObject(unlockManager)
                // Automatically save when we detect that we are no longer
                // the foreground app. Use this rather than the scene phase
                // API so we can port to macOS, where scene phase won't detect
                // our app losing focus as of macOS 11.1.
                .onReceive(
                    NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification),
                    perform: save)
                .onAppear(perform: dataController.appLaunched)
        }
    }

    func save(_ note: Notification) {
        dataController.save()
    }
}
