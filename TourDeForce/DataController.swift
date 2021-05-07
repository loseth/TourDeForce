//
//  DataController.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-10-22.
//

import CoreData
import CoreSpotlight
import SwiftUI

/// An environment singleton responsible for managing our Core Data stack, including saving,
/// counting fetch requests, tracking awards and dealing with sample data.
class DataController: ObservableObject {

    /// The lone CloudKit container used to store all our data.
    let container: NSPersistentCloudKitContainer

    /// Initialises a data controller, either in memory (for temporary use such as testing and previewing).
    /// or on permanent storage (for use in regular app runs).
    ///
    /// Defaults to permanent storage.
    /// - Parameter inMemory: Whether to store this data in temporary memory or not.
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main", managedObjectModel: Self.model)

        // For testing and previewing purposes, we create a temporary,
        // in-memory database by writing to /dev/null so our data is
        // destroyed after the app finishes running.
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }

            #if DEBUG
            if CommandLine.arguments.contains("enable-testing") {
                self.deleteAll()
                UIView.setAnimationsEnabled(false)
            }
            #endif
        }
    }

    static var preview: DataController = {
        let dataController = DataController(inMemory: true)

        do {
            try dataController.createSampleData()
        } catch {
            fatalError("Fatal error creating preview: \(error.localizedDescription)")
        }

        return dataController
    }()

    static let model: NSManagedObjectModel = {
        guard let url = Bundle.main.url(
                forResource: "Main",
                withExtension: "momd") else { fatalError("Failed to locate model file.")
        }

        guard let managedObjectModel = NSManagedObjectModel(
                contentsOf: url) else { fatalError("Failed to load model file.")
        }

        return managedObjectModel
    }()

    /// Creates example projects and items to make manual testing easier.
    /// - Throws: An NSError sent from calling save() on the NSManagedObjectContext.
    /// - Note: For testing and previewing purposes, it was previously used in conjunction with
    /// deleteAll() to create and delete sample data.  Keep the code, it could be useful later.
    func createSampleData() throws {
        let viewContext = container.viewContext

        for projectCounter in 1...5 {
            let project = Project(context: viewContext)
            project.closed = Bool.random()
            project.creationDate = Date()
            project.items = []
            project.title = "Project \(projectCounter)"

            for itemCounter in 1...10 {
                let item = Item(context: viewContext)
                item.completed = Bool.random()
                item.creationDate = Date()
                item.priority = Int16.random(in: 1...3)
                // Core Data will with this add the item to the project.items array
                item.project = project
                item.title = "Item \(itemCounter)"
            }
        }

        try viewContext.save()
    }

    /// Saves our Code Data context iff there are changes. This silently ignores
    /// any errors caused by saving, but this should be fine because our
    /// attributes are optional.
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }

    /// Remove a record from the Core Data context.
    /// Remove Spotlight search result for all items for a project with a unique identifier.
    /// - Parameter object: A Core Data record to be removed.
    func delete(_ object: Project) {
        let id = object.objectID.uriRepresentation().absoluteString
        CSSearchableIndex.default().deleteSearchableItems(withDomainIdentifiers: [id])

        container.viewContext.delete(object)
    }

    /// Remove a record from the Core Data context.
    /// Remove Spotlight search result for items with a unique identifier.
    /// - Parameter object: A Core Data record to be removed.
    func delete(_ object: Item) {
        let id = object.objectID.uriRepresentation().absoluteString
        CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: [id])

        container.viewContext.delete(object)
    }

    /// Remove all records (that has objects of type Item and Project) from the Core Data context.
    /// - Note: For testing and previewing purposes, it was previously used in conjunction with
    /// createSampleData() to create and delete sample data. Keep the code, it could be useful later.
    func deleteAll() {
        let fetchRequest1: NSFetchRequest<NSFetchRequestResult> = Item.fetchRequest()
        let batchDeleteRequest1 = NSBatchDeleteRequest(fetchRequest: fetchRequest1)
        _ = try? container.viewContext.execute(batchDeleteRequest1)

        let fetchRequest2: NSFetchRequest<NSFetchRequestResult> = Project.fetchRequest()
        let batchDeleteRequest2 = NSBatchDeleteRequest(fetchRequest: fetchRequest2)
        _ = try? container.viewContext.execute(batchDeleteRequest2)
    }

    /// Count all  Core Data context records, that has an object of generic type T..
    /// - Parameter fetchRequest: A fetch request for a Core Data record that has an object of generic type T.
    /// - Returns: Number of Core Data records that has an object of generic type T.
    func count<T>(for fetchRequest: NSFetchRequest<T>) -> Int {
        (try? container.viewContext.count(for: fetchRequest)) ?? 0
    }

    /// Whether enough tasks have been achieved to earn an award,
    /// either from adding or completing a certain number of items,
    /// - Parameter award: An Award object.
    /// - Returns: Whether an award is earned or not.
    /// - Todo: See code comment for default case
    func hasEarned(award: Award) -> Bool {
        switch award.criterion {
        case "items":
            // returns true if they added a certain number of items
            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        case "complete":
            // returns true is they completed a certain number of items
            let fetchRequest: NSFetchRequest<Item> = NSFetchRequest(entityName: "Item")
            fetchRequest.predicate = NSPredicate(format: "completed = true")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value
        default:
            // an unknown award criterion; this should never be allowed

            // Uncomment, replace "return false" with fatalError, before production stage
            // fatalError("Unknown award criterion: \(award.criterion).")
            // TRL: 2021-01-19
            return false
        }
    }

    /// In Spotlight, include results from a query for an item.
    /// - Parameter item: The item to be queried for.
    func update(_ item: Item) {
        let itemID = item.objectID.uriRepresentation().absoluteString
        let projectID = item.project?.objectID.uriRepresentation().absoluteString

        let attributeSet = CSSearchableItemAttributeSet(contentType: .text)
        attributeSet.title = item.itemTitle
        attributeSet.contentDescription = item.itemDetail

        let searchableItem = CSSearchableItem(
            uniqueIdentifier: itemID,
            domainIdentifier: projectID,
            attributeSet: attributeSet
        )

        CSSearchableIndex.default().indexSearchableItems([searchableItem])

        save()
    }

    /// Find and return an item from Core Data given a unique identifier
    /// - Parameter uniqueIdentifier: A unique identifier to query Core Data with.
    /// - Returns: The found item, or nil if not found.
    func item(with uniqueIdentifier: String) -> Item? {
        guard let url = URL(string: uniqueIdentifier) else { return nil }

        guard let id = container.persistentStoreCoordinator.managedObjectID(forURIRepresentation: url) else {
            return nil
        }

        return try? container.viewContext.existingObject(with: id) as? Item
    }
}
