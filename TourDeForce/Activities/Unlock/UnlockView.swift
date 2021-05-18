//
//  UnlockView.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2021-05-18.
//

import StoreKit
import SwiftUI

/// The UI for showing store state - if it's ok to go to unlocking a product or not.
struct UnlockView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var unlockManager: UnlockManager

    var body: some View {
        VStack {
            switch unlockManager.requestState {
            case .loaded(let product):
                ProductView(product: product)
                // Here I could fetch and display the error from unlockmanager…
            case .failed(_):
                Text("Sorry, there was an error loading the store. Please try again later.")
            case .loading:
                ProgressView("Loading…")
            case .purchased:
                Text("Thank you!")
            case .deferred:
                Text("Thank you! Your request is pending approval, but you can carry on using the app in the meantime.")
            }
        }
        .padding()
        .onReceive(unlockManager.$requestState) { value in
            if case .purchased = value {
                dismiss()
            }
        }
    }

    /// Dismiss store state window
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}
