//
//  MockNetworkManagerTests.swift
//  LBG_Virtusa-iOSTechTestTests
//
//  Created by kanagasabapathy on 13/10/23.
//

import Foundation
@testable import LBG_Virtusa_iOSTechTest
import XCTest
class MockNetworkManagerTests: XCTestCase {
    func testFetchDataFromURLSuccessCase() async throws {
        let mockNetworkManager = MockNetworkManager()
        let repo = CurrencyListRepository(networkManager: mockNetworkManager)
        let urlString = "currencyData"
        if let url = URL(string: urlString)  {
            let data = try await repo.fetchCurrencyList(for: url)
            XCTAssertNotNil(data, "Data Should not be nil")
        }
    }
    func testFetchDataFromURLInvalidCase() async throws {
        let mockNetworkManager = MockNetworkManager()
        let repo = CurrencyListRepository(networkManager: mockNetworkManager)
        let urlString = "invalidcurrencyData"
        guard let url = URL(string: urlString) else {
            return XCTFail("Expected Error - URL String not exists")
        }

        do {
            _ = try await repo.fetchCurrencyList(for: url)
            XCTFail("Expected Error")
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.badUrl, "Error should be dataNotFound")
        } catch {
            XCTFail("Error: \(error)")
        }


    }
}
