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
    
    //MARK: - KeyPath
    
    //    Used in func items(for project: Project) -> [Item] in file "ProjectsView"
    //  It can be replaced by the two functions directly below.
    //
//    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
//        self.sorted {
//            $0[keyPath: keyPath] < $1[keyPath: keyPath]
//        }
//    }
    
    func sorted<Value>(by keyPath: KeyPath<Element, Value>, using areInIncreasingOrder: (Value, Value) throws -> Bool) rethrows -> [Element] {
        try self.sorted {
            try areInIncreasingOrder($0[keyPath: keyPath], $1[keyPath: keyPath])
        }
    }

    func sorted<Value: Comparable>(by keyPath: KeyPath<Element, Value>) -> [Element] {
        self.sorted(by: keyPath, using: <)
    }
    
}
