//
//  Binding-OnChange.swift
//  TourDeForce
//
//  Created by Tor Rafsol Løseth on 2020-10-27.
//

import SwiftUI

extension Binding {
    func onChange(_ handler: @escaping () -> Void) -> Binding<Value> {
        Binding(
            get: { self.wrappedValue },
            set: { newValue in
                self.wrappedValue = newValue
                handler()
            }
        )
    }
}
