//
//  Sequence-Sorting.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-11-07.
//

import Foundation

//TODO: - Make a branch for KeyPaths/PartialKeyPaths to explore these alternatives to sorting.

// Alternatives to using enums for sorting: KeyPaths or PartialKeyPaths to sort items
// Will not be used, not a good idea in this project!
extension Sequence {
    
    //MARK: - KeyPath
    
    func sorted<Value>(by keyPath: KeyPath<Element, Value>, using areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
    
    func sorted<Value: Comparable>(byy keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted(by: keyPath, using: <)
    }
    
    
    //MARK: - PartialKeyPath
    
    func sorted<Value>(by keyPath: PartialKeyPath<Element>, using areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            guard let value1 = $0[keyPath: keyPath] as? Value else { return false }
            guard let value2 = $1[keyPath: keyPath] as? Value else { return false }
            
            return try areInIncreasingOrder(value1, value2)
        }
    }
    
    func sorted<Value: Comparable>(by keyPath: PartialKeyPath<Element>) -> ([Element], Value?) {
        let function: (Value, Value) -> Bool = (<)

        return (self.sorted(by: keyPath, using: function), nil)
    }
    
    // slightly better than the one above
    func sorted<Value: Comparable>(by keyPath: PartialKeyPath<Element>, as: Value.Type? = nil) -> [Element] {
        let function: (Value, Value) -> Bool = (<)
        
        return self.sorted(by: keyPath, using: function)
    }
}
