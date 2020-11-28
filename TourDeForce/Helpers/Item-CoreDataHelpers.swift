//
//  Item-CoreDataHelpers.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-10-24.
//

import Foundation

extension Item {
    enum SortOrder {
        case optimized, title, creationDate
    }
    var itemTitle: String {
        title ?? NSLocalizedString("New Item", comment: "Create a new Item")
    }
    
    var itemDetail: String {
        detail ?? ""
    }
    
    var itemCreationDate: Date {
        creationDate ?? Date()
    }
    
    static var example: Item {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let item = Item(context: viewContext)
        item.title = "Example Item"
        item.detail = "This is an example item"
        item.priority = 3
        item.creationDate = Date()
        
        return item
    }
}
