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

    let showClosedProjects: Bool
    let projects: FetchRequest<Project>

    init(showClosedProjects: Bool) {
        self.showClosedProjects = showClosedProjects

        projects = FetchRequest<Project>(
            entity: Project.entity(),
            sortDescriptors: [NSSortDescriptor(
                                keyPath: \Project.creationDate,
                                ascending: false)
        ],
            predicate: NSPredicate(format: "closed = %d", showClosedProjects))
    }

    var projectsList: some View {
        List {
            ForEach(projects.wrappedValue) { project in
                Section(header: ProjectHeaderView(project: project)) {
                    ForEach(project.projectItems(using: sortOrder)) { item in
                        ItemRowView(project: project, item: item)
                    }
                    .onDelete { offsets in
                        delete(offsets, from: project)
                    }

                    if showClosedProjects == false {
                        Button {
                            addItem(to: project)
                        } label: {
                            Label("Add New Item", systemImage: "plus")
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }

    var addProjectToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            if showClosedProjects == false {
                Button(action: addProject) {

                    // MARK: - iOS accessibility bug with the + sign for adding projects
                    // In iOS 14.3 VoiceOver has a glitch that reads the lable
                    // "Add Project" as "Add" no matter what accessibility label
                    // we give this toolbar button when using a label.
                    // As a result, when VoiceOver is running, we use a text view for
                    // the button instead, forcing a correct reading withou losing
                    // the original layout.
                    //
                    // Todo: - Remove this hack when iOS fixed
                    // TRL: 2021-01-19
                    if UIAccessibility.isVoiceOverRunning {
                        Text("Add Project")
                    } else {
                        Label("Add Project", systemImage: "plus")
                    }

                    // Revert to this again when fixed
//                            Label("Add Project", systemImage: "plus")
                }
            }
        }
    }

    var sortOrderToolbarItem: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            Button {
                showingSortOrder.toggle()
            } label: {
                Label("Sort", systemImage: "arrow.up.arrow.down")
            }
        }
    }

    var body: some View {
        NavigationView {
            Group {
                if projects.wrappedValue.isEmpty {
                    Text("There's nothing here right now")
                        .foregroundColor(.secondary)
                } else {
                    projectsList
                }
            }
            .navigationTitle(showClosedProjects ? "Closed Projects" : "Open Projects")
            .toolbar {
                addProjectToolbarItem
                sortOrderToolbarItem
            }
            .actionSheet(isPresented: $showingSortOrder) {
                ActionSheet(title: Text("Sort items"), message: nil, buttons: [
                    .default(Text("Optimized")) { sortOrder = .optimized },
                    .default(Text("Creation Date")) { sortOrder = .creationDate },
                    .default(Text("Title")) { sortOrder = .title }
                ])
            }

            SelectSomethingView()
        }
    }

    func addProject() {
        withAnimation {
            let project = Project(context: managedObjectContext)
            project.closed = false
            project.creationDate = Date()
            dataController.save()
        }
    }

    func addItem(to project: Project) {
        withAnimation {
            let item = Item(context: managedObjectContext)
            item.project = project
            item.creationDate = Date()
            dataController.save()
        }
    }

    func delete(_ offsets: IndexSet, from project: Project) {
        // allItems will hold all items even if we delete items from Core Data
        let allItems = project.projectItems(using: sortOrder)

        for offset in offsets {
            let item = allItems[offset]
            // This will hold on to items and delete all at the end of the run loop
            dataController.delete(item)
        }

        // This however will delete all pending items immediately
        // dataController.container.viewContext.processPendingChanges()
        dataController.save()
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
