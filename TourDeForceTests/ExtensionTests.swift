//
//  ExtensionTests.swift
//  TourDeForceTests
//
//  Created by Tor Rafsol Løseth on 2021-02-02.
//

import SwiftUI
import XCTest
@testable import TourDeForce

class ExtensionTests: XCTestCase {

    /// Test for sorting comparable values using a key path and the comparator function '<' (ascending).
    func testSequenceKeyPathSortingSelf() {
        // Given, When
        let items = [1, 4, 3, 2, 5]
        let sortedItems = items.sorted(by: \.self)

        // Then
        XCTAssertEqual(sortedItems, [1, 2, 3, 4, 5], "The sorted number must be ascending.")
    }

    /// Test for sorting comparable values using a key path and any custom comparator function.
    /// Here using '>' (descending) as one example.
    func testSequenceKeyPathSortingCustomComparable() {
        // Given, When
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

        // Then
        XCTAssertEqual(sortedItems, [example3, example2, example1], "Reverse sorting should yield c, b, a.")
    }

    /// Test for loading and decoding of type 'Award' with the custom JSON decode function.
    func testBundleDecodingAwards() {
        // Given, When
        let awards = Bundle.main.decode([Award].self, from: "Awards.json")

        // Then
        XCTAssertFalse(awards.isEmpty, "Awards.json should decode to a non-empty array.")
    }

    /// Test for loading and decoding of type a single string with the custom JSON decode function.
    func testDecodingString() {
        // Given, When
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(String.self, from: "DecodableString.json")

        // Then
        XCTAssertEqual(
            data,
            "The rain in Spain falls mainly on the Spaniards.",
            "The string must match the content of DecodableString.json."
        )
    }

    /// Test for loading and decoding correct number of items, and correct key-value mappings,
    /// with the custom JSON decode function.
    func testDecodingDictionary() {
        // Given, When
        let bundle = Bundle(for: ExtensionTests.self)
        let data = bundle.decode(Dictionary<String, Int>.self, from: "DecodableDictionary.json")

        // Then
        XCTAssertEqual(data.count, 3, "There should be 3 items decoded from DecodableDictionary.json.")
        XCTAssertEqual(data["One"], 1, "The dictionary should contain Int to String mappings.")
    }

    /// Test that the onChange() function is run when a binding is changed.
    func testBindingOnChangeCallsFunction() {
        // Given
        var onChangeFunctionRun = false

        func exampleFunctionToCall() {
            onChangeFunctionRun = true
        }

        var storedValue = ""

        let binding = Binding(
            get: { storedValue },
            set: { storedValue = $0 }
        )

        let changedBinding = binding.onChange(exampleFunctionToCall)

        // When
        changedBinding.wrappedValue = "Test"

        // Then
        XCTAssertTrue(onChangeFunctionRun, "The onChange() function must be run when the binding is changed.")
    }
}
