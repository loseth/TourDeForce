//
//  Sequence-Sorting.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-11-07.
//

import Foundation

extension Sequence {

    func sorted<Value>(
        by keyPath: KeyPath<Element, Value>,
        using areInIncreasingOrder: (Value, Value) throws -> Bool
    ) rethrows -> [Element] {
            try self.sorted {
                try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
            }
        }

        func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
            self.sorted(by: keyPath, using: <)
        }
}
