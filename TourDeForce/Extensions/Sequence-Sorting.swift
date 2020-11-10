//
//  Sequence-Sorting.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-11-07.
//

import Foundation

// Alternatives to using enum for sorting: NSSortDescriptor
// Will not be used, not a good idea in this project!
extension Sequence {
    
    //MARK: - NSSortDescriptor
    
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
}
