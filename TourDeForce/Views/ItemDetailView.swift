//
//  ItemDetailView.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-12-07.
//

import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var item: Item

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.itemTitle)
                .font(.title2)
                .foregroundColor(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)

            if item.itemDetail.isEmpty == false {
                Text(item.itemDetail)
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ItemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ItemDetailView(item: Item.example)
    }
}
