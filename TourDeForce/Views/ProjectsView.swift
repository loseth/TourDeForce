//
//  ProjectsView.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-10-22.
//

import SwiftUI

struct ProjectsView: View {
    // Optional because @SceneStorage in ContentView is optional
    static let openTag: String? = "Open"
    static let closedTag: String? = "Closed"
    
    @EnvironmentObject var dataController: DataController
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var showingSortOrder = false
    @State private var sortOrder = Item.SortOrder.optimized
    
    @State var sortDescriptor: NSSortDescriptor?
    
    let showClosedProjects: Bool
    let projects: FetchRequest<Project>
    
    let titleSortDescriptor = NSSortDescriptor(keyPath: \Item.title, ascending: true)
    let creationDateSortDescriptor = NSSortDescriptor(keyPath: \Item.creationDate, ascending: true)
    
    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects
        
        projects = FetchRequest<Project>(entity: Project.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)
        ], predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(projects.wrappedValue) { project in
                    Section(header: ProjectHeaderView(project: project)) {
                        ForEach(items(for: project)) { item in
                            ItemRowView(item: item)
                        }
                        .onDelete { offsets in
                            // allItems will hold all items even if we delete items from Core Data
                            let allItems = project.projectItems
                            
                            for offset in offsets {
                                let item = allItems[offset]
                                // This will hold on to items and delete all at the end of the run loop
                                dataController.delete(item)
                            }
                            
                            // This however will delete all pending items immediately
                            //                            dataController.container.viewContext.processPendingChanges()
                            dataController.save()
                        }
                        
                        if showClosedProjects == false {
                            Button {
                                withAnimation {
                                    let item = Item(context: managedObjectContext)
                                    item.project = project
                                    item.creationDate = Date()
                                    dataController.save()
                                }
                            } label: {
                                Label("Add New Item", systemImage: "plus")
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if showClosedProjects == false {
                        Button {
                            withAnimation {
                                let project = Project(context: managedObjectContext)
                                project.closed = false
                                project.creationDate = Date()
                                dataController.save()
                            }
                        } label: {
                            Label("Add Project", systemImage: "plus")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingSortOrder.toggle()
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Optimized")) { sortDescriptor = nil },
                    .default(Text("Creation Date")) { sortDescriptor = creationDateSortDescriptor },
                    .default(Text("Title")) { sortDescriptor = titleSortDescriptor }
                ])
            }
        }
    }
    
    func items(for project: Project) -> [Item] {
        guard let sortDescriptor = sortDescriptor else { return project.projectItemsDefaultSorted }
        
        return project.projectItems.sorted(by: sortDescriptor)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var dataController = DataController.preview
    
    static var previews: some View {
        ProjectsView(showClosedProjects: false)
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
    }
}
