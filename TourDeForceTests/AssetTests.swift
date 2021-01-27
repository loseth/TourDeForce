//
//  AssetTests.swift
//  TourDeForceTests
//
//  Created by Tor Rafsol Løseth on 2021-01-27.
//

import XCTest
@testable import TourDeForce

class AssetTests: XCTestCase {
    func testColorsExist() {
        for color in Project.colors {
            XCTAssertNotNil(UIColor(named: color), "Failed to load color '\(color)' from asset catalog.")
        }
    }

    func testJSONLoadsCorrectly() {
        XCTAssertFalse(Award.allAwards.isEmpty, "Failed to load awards from JSON.")
    }
}
