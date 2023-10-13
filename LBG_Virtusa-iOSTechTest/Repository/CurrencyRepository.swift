//
//  CurrencyRepository.swift
//  LBG_Virtusa-iOSTechTest
//
//  Created by kanagasabapathy on 13/10/23.
//

import Foundation

protocol CurrencyRepository {
    func fetchCurrencyList(for url: URL) async throws -> CurrencyData
}
