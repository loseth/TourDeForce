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
}
