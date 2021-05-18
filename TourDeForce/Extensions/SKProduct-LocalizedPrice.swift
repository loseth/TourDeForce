//
//  SKProduct-LocalizedPrice.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2021-05-18.
//

import StoreKit

extension SKProduct {
    var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale

        return formatter.string(from: price)!
    }
}
