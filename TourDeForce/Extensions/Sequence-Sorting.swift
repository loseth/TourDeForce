//
//  Sequence-Sorting.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-11-07.
//

import Foundation

// Alternatives to using enums for sorting: KeyPaths/PartialKeyPaths or NSSortDescriptor to sort items
// Will not be used, not a good idea in this project!
extension Sequence {
    
    //MARK: - KeyPath
    //TODO: - Make a branch for KeyPaths to explore alternative to sorting by enum.
    
    func sorted<Value>(by keyPath: KeyPath<Element, Value>, using areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }
    
    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted(by: keyPath, using: <)
    }
    
    
    //MARK: - PartialKeyPath
    //TODO: - Make a branch for PartialKeyPaths to explore alternative to sorting by enum.
    
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
    
    //MARK: - NSSortDescriptor
    //TODO: - Make a branch for NSSortDescriptor to explore alternative to sorting by enum.
    
    func sorted(by sortDescriptor: NSSortDescriptor) -> [Element] {
        self.sorted {
            sortDescriptor.compare($0, to: $1) == .orderedAscending
        }
    }
    
    func sorted(by sortDescriptors: [NSSortDescriptor]) ->[Element] {
        self.sorted {
            for descriptor in sortDescriptors {
                switch descriptor.compare($0, to: $1) {
                case .orderedAscending:
                    return true
                case .orderedDescending:
                    return true
                case .orderedSame:
                    continue
                }
            }
            return false
        }
    }
    
    //MARK: - PartialKeyPath and NSSortDescriptor
    //TODO: - Make a branch for PartialKeyPath and NSSortDescriptor to explore alternative to sorting by enum.
    
    // Warning: _kvcKeyPathStringis an undocumented piece of key path API.
    func sorted(by keyPath: PartialKeyPath<Element>) -> [Element] {
        guard let keyPathString = keyPath._kvcKeyPathString else { return Array(self) }
        let sortDescriptor = NSSortDescriptor(key: keyPathString, ascending: true)
        
        return self.sorted(by: sortDescriptor)
    }
    
    
}
