//
//  BitcoinAppApp.swift
//  BitcoinApp
//
//  Created by Alejandro Villagrán Poblete on 31-07-23.
//

import SwiftUI

@main
struct BitcoinAppApp: App {
    var body: some Scene {
        WindowGroup {
          BitcoinPriceView(viewModel: BitcoinPriceViewModel())
        }
    }
}
