//
//  AwardTests.swift
//  TourDeForceTests
//
//  Created by Tor Rafsol Løseth on 2021-01-28.
//

import CoreData
import XCTest
@testable import TourDeForce

class AwardTests: BaseTestCase {
    let awards = Award.allAwards

    func testAwardIDMatchesName() {
        for award in awards {
            XCTAssertEqual(award.id, award.name, "Award ID should always match its name.")
        }
    }

    func testNewUserHasNoAwards() throws {
        for award in awards {
            XCTAssertFalse(dataController.hasEarned(award: award), "New users should have no earned awards")
        }
    }

    func testAddingItems() {
        // Awards given equals the array index + 1
        let itemsAdded = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (index, value) in itemsAdded.enumerated() {
            for _ in 0..<value {
                _ = Item(context: managedObjectContext)
            }

            let matches = awards.filter { award in
                award.criterion == "items" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, index + 1, "Adding \(value) items should unlock \(index + 1) awards.")

            dataController.deleteAll()
        }
    }

    func testCompletingItems() {
        // Awards given equals the array index + 1
        let itemsCompleted = [1, 10, 20, 50, 100, 250, 500, 1000]

        for (index, value) in itemsCompleted.enumerated() {
            for _ in 0..<value {
                let item = Item(context: managedObjectContext)
                item.completed = true
            }

            let matches = awards.filter { award in
                award.criterion == "complete" && dataController.hasEarned(award: award)
            }

            XCTAssertEqual(matches.count, index + 1, "Completing \(value) items should unlock \(index + 1) awards.")

            dataController.deleteAll()
        }
    }
}
