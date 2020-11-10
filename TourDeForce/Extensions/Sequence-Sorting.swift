//
//  Sequence-Sorting.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-11-07.
//

import Foundation

// Alternatives to using enums for sorting: KeyPaths/PartialKeyPaths or NSSortDescriptor
// Will not be used, not a good idea in this project!
extension Sequence {
    
    //MARK: - NSSortDescriptor

    func sorted(by sortDescriptor: NSSortDescriptor) -> [Element] {
        self.sorted {
            sortDescriptor.compare($0, to: $1) == .orderedAscending
        }
    }

//    func sorted(by sortDescriptors: [NSSortDescriptor]) ->[Element] {
//        self.sorted {
//            for descriptor in sortDescriptors {
//                switch descriptor.compare($0, to: $1) {
//                case .orderedAscending:
//                    return true
//                case .orderedDescending:
//                    return true
//                case .orderedSame:
//                    continue
//                }
//            }
//            return false
//        }
//    }
    
    //MARK: - PartialKeyPath and NSSortDescriptor
    
    // Warning: _kvcKeyPathStringis an undocumented piece of key path API.
    func sorted(by keyPath: PartialKeyPath<Element>) -> [Element] {
        guard let keyPathString = keyPath._kvcKeyPathString else { return Array(self) }
        let sortDescriptor = NSSortDescriptor(key: keyPathString, ascending: true)
        
        return self.sorted(by: sortDescriptor)
    }
    
    
}
