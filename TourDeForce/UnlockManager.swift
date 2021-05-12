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

    private let dataController: DataController
    private let request: SKProductsRequest
    private let loadedProducts = [SKProduct]()

    init(dataController: DataController) {
        self.dataController = dataController

        let productIDs = Set(["com.codecabal.TourDeForce.unlock"])
        request = SKProductsRequest(productIdentifiers: productIDs)

        super.init()

        SKPaymentQueue.default().add(self)
        request.delegate = self
        request.start()
    }

    deinit {
        SKPaymentQueue.default().remove(self)
    }

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {

    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {

    }
}
