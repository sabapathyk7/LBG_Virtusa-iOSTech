//
//  MockNetworkManager.swift
//  LBG_Virtusa-iOSTechTestTests
//
//  Created by kanagasabapathy on 13/10/23.
//

import Foundation
@testable import LBG_Virtusa_iOSTechTest

class MockNetworkManager: Networkable {
    func fetchDataFromURL(url: URL) async throws -> Data {
        do {
            let bundle = Bundle(for: MockNetworkManager.self)
            guard let path = bundle.url(forResource: url.absoluteString, withExtension: ".json") else {
                throw NetworkError.badUrl
            }
            let data = try Data(contentsOf: path)
            return data
        } catch {
            throw NetworkError.generic
        }
    }
}
