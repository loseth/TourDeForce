//
//  ProductView.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2021-05-18.
//

import StoreKit
import SwiftUI

/// The UI for unlocking IAP for a single product
struct ProductView: View {
    @EnvironmentObject var unlockManager: UnlockManager
    let product: SKProduct

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Get Unlimited Projects")
                    .font(.headline)
                    .padding(.top, 10)
                Text("You can add three projects for free, or pay \(product.localizedPrice) to add unlimited projects.")
                Text("If you already bought the unlock on another device, press Restore Purchases.")

                Button("Buy: \(product.localizedPrice)", action: unlock)
                    .buttonStyle(PurchaseButton())

                Button("Restore Purchases", action: unlockManager.restore)
                    .buttonStyle(PurchaseButton())
            }
        }
    }

    /// Buy the product
    func unlock() {
        unlockManager.buy(product: product)
    }
}
