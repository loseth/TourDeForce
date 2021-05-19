//
//  ProjectsViewModel.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2021-04-14.
//

import CoreData
import Foundation

extension ProjectsView {
    class ViewModel: NSObject, ObservableObject, NSFetchedResultsControllerDelegate {
        @Published var projects = [Project]()
        @Published var showingUnlockView = false

        private let projectsController: NSFetchedResultsController<Project>

        let dataController: DataController
        let showClosedProjects: Bool

        var sortOrder = Item.SortOrder.optimized

        init(dataController: DataController, showClosedProjects: Bool) {
            self.dataController = dataController
            self.showClosedProjects = showClosedProjects

            let request: NSFetchRequest<Project> = Project.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(keyPath: \Project.creationDate, ascending: false)]
            request.predicate = NSPredicate(format: "closed = %d", showClosedProjects)

            projectsController = NSFetchedResultsController(
                fetchRequest: request,
                managedObjectContext: dataController.container.viewContext,
                sectionNameKeyPath: nil,
                cacheName: nil
            )

            super.init()
            projectsController.delegate = self

            do {
                try projectsController.performFetch()
                projects = projectsController.fetchedObjects ?? []
            } catch {
                print("Failed to fetch projects!")
            }
        }

        func addProject() {
            if dataController.addProject() == false {
                showingUnlockView.toggle()
            }
        }

        func addItem(to project: Project) {
            let item = Item(context: dataController.container.viewContext)
            item.project = project
            item.creationDate = Date()
            dataController.save()
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

        func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
            if let newProjects = controller.fetchedObjects as? [Project] {
                projects = newProjects
            }
        }
    }
}
