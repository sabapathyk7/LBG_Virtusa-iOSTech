//
//  CurrencyListRepository.swift
//  LBG_Virtusa-iOSTechTest
//
//  Created by kanagasabapathy on 13/10/23.
//

import Foundation

final class CurrencyListRepository: CurrencyRepository {

    let networkManager: Networkable

    init(networkManager: Networkable) {
        self.networkManager = networkManager
    }

    func fetchCurrencyList(for url: URL) async throws -> CurrencyData {
        let data = try await self.networkManager.fetchDataFromURL(url: url)
        let currencyData = try JSONDecoder().decode(CurrencyData.self, from: data)
        return currencyData
    }


}
