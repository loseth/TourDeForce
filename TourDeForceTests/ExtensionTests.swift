//
//  ExtensionTests.swift
//  TourDeForceTests
//
//  Created by Tor Rafsol Løseth on 2021-02-02.
//

import XCTest
@testable import TourDeForce

class ExtensionTests: XCTestCase {
    func testSequenceKeyPathSortingSelf() {
        let items = [1, 4, 3, 2, 5]
        let sortedItems = items.sorted(by: \.self)
        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "The sorted number must be ascending.")
    }

    func testSequenceKeyPathSortingCustomComparable() {
        struct Example: Equatable {
            let value: String
        }

        let example1 = Example(value: "a")
        let example2 = Example(value: "b")
        let example3 = Example(value: "c")
        let examples = [example1, example2, example3]

        let sortedItems = examples.sorted(by: \.value) {
            $0 > $1
        }

        XCTAssertEqual(sortedItems, [example3, example2, example1], "Reverse sorting should yield c, b, a.")
    }
}
