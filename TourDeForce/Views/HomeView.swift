//
//  HomeView.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-10-22.
//

import SwiftUI

struct HomeView: View {
    // Optional becuase @SceneStorage in ContentView is optional
    static let tag: String? = "Home"
    
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Add Data") {
                    dataController.deleteAll()
                    dataController.save()
                    try? dataController.createSampleData()
                }
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
