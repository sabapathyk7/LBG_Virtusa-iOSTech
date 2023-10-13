//
//  LBG_Virtusa_iOSTechTestApp.swift
//  LBG_Virtusa-iOSTechTest
//
//  Created by kanagasabapathy on 13/10/23.
//

import SwiftUI

@main
struct LBG_Virtusa_iOSTechTestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: CurrencyListViewModel(currencyListRepo: CurrencyListRepository(networkManager: NetworkManager())), isErrorOccured: false)
        }
    }
}
