//
//  DevelopmentTests.swift
//  TourDeForceTests
//
//  Created by Tor Rafsol Løseth on 2021-01-28.
//

import CoreData
import XCTest
@testable import TourDeForce

class DevelopmentTests: BaseTestCase {
    func testSampleDataCreationWorks() throws {
        try dataController.createSampleData()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 5, "There should be 5 sample projects")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 50, "There should be 50 sample projects")
    }

    func testSampleDataDeletingWorks() throws {
        try dataController.createSampleData()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Project.fetchRequest()), 0, "deleteAll() should leave 0 projects")
        XCTAssertEqual(dataController.count(for: Item.fetchRequest()), 0, "deleteAll() should leave 0 items")
    }
}
