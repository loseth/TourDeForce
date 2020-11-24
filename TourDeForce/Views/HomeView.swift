//
//  HomeView.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-10-22.
//

import CoreData
import SwiftUI

struct HomeView: View {
    // Optional becuase @SceneStorage in ContentView is optional
    static let tag: String? = "Home"
    
    @EnvironmentObject var dataController: DataController
    
    @FetchRequest(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.title, ascending: true)], predicate: NSPredicate(format: "closed = false")) var projects: FetchedResults<Project>
    
    let items: FetchRequest<Item>
    
    init() {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        
        request.predicate = NSPredicate(format: "completed = false")
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Item.priority, ascending: false)]
        request.fetchLimit = 10
        
        items = FetchRequest(fetchRequest: request)
    }
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                
            }
            .background(Color.systemGroupedBackground.ignoresSafeArea())
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}




//VStack {
//    Button("Add Data") {
//        dataController.deleteAll()
//        dataController.save()
//        try? dataController.createSampleData()
//    }
//}
//.navigationTitle("Home")
