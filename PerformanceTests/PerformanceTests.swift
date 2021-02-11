//
//  PerformanceTests.swift
//  PerformanceTests
//
//  Created by Tor Rafsol Løseth on 2021-02-11.
//

import CoreData
import XCTest
@testable import TourDeForce

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
