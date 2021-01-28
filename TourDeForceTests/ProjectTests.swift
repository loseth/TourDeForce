//
//  ProjectTests.swift
//  TourDeForceTests
//
//  Created by Tor Rafsol Løseth on 2021-01-28.
//

import CoreData
import XCTest
@testable import TourDeForce

class ProjectTests: BaseTestCase {
    func testCreatingProjectsAndItems() {
        let targetCount = 10

        for _ in 0..<targetCount {
            let project = Project(context: managedObjectContext)

            for _ in 0..<targetCount {
                let item = Item(context: managedObjectContext)
                item.project = project
            }
        }

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()),
                       targetCount,
                       "Failed to create \(targetCount) projects.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()),
                       targetCount * targetCount,
                       "Failed to create \(targetCount) items.")
    }

    func testDeletingProjectCascadeDeletesItems() throws {
        // Creates 5 projects, each with 10 items.
        try dataController.createSampleData()

        let request = NSFetchRequest<Project>(entityName: "Project")
        let projects = try managedObjectContext.fetch(request)

        dataController.delete(projects[0])

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 4, "Failed to delete 1 project.")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 40, "Failed to delete 10 items.")
    }
}
