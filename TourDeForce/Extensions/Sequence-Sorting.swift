//
//  Sequence-Sorting.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-11-07.
//

import Foundation

// Alternatives to using enum for sorting: KeyPath
// Will not be used, not a good idea in this project!
extension Sequence {
    
    //MARK: - PartialKeyPath
    
    func sorted<Value>(by keyPath: PartialKeyPath<Element>, using areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            guard let value1 = $0[keyPath: keyPath] as? Value else { return false }
            guard let value2 = $1[keyPath: keyPath] as? Value else { return false }
            
            return try areInIncreasingOrder(value1, value2)
        }
    }
    
//    func sorted<Value: Comparable>(by keyPath: PartialKeyPath<Element>) -> ([Element], Value?) {
//        let function: (Value, Value) -> Bool = (<)
//
//        return (self.sorted(by: keyPath, using: function), nil)
//    }
    
    // slightly better than the one above
    func sorted<Value: Comparable>(by keyPath: PartialKeyPath<Element>, as: Value.Type? = nil) -> [Element] {
        let function: (Value, Value) -> Bool = (<)
        
        return self.sorted(by: keyPath, using: function)
    }
}
