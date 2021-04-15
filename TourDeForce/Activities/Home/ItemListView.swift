//
//  ItemListView.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-12-06.
//

import SwiftUI

struct ItemListView: View {
    let title: LocalizedStringKey
    let items: ArraySlice<Item>

    var body: some View {
        if items.isEmpty {
            EmptyView()
        } else {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.top)

            ForEach(items) { item in
                NavigationLink(destination: EditItemView(item: item)) {
                    HStack(spacing: 20) {
                        Circle()
                            .stroke(Color(item.project?.projectColor ?? "Light Blue"), lineWidth: 2)
                            .frame(width: 44, height: 44)

                        ItemDetailView(item: item)
                    }
                    .padding()
                    .background(Color.secondarySystemGroupedBackground)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5)
                }
            }
        }
    }
}
