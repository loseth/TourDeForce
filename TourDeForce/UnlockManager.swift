//
//  UnlockManager.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2021-05-12.
//

import Combine
import StoreKit

class UnlockManager: NSObject, ObservableObject, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    enum RequestState {
        case loading
        case loaded
        case failed
        case purchased
        case deferred
    }

    @Published var requestState = RequestState.loading

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

    }
}
