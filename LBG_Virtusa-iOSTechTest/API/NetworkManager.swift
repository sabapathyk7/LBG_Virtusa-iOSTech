//
//  NetworkManager.swift
//  LBG_Virtusa-iOSTechTest
//
//  Created by kanagasabapathy on 13/10/23.
//

import Foundation

protocol Networkable {
    func fetchDataFromURL(url: URL) async throws -> Data
}

class NetworkManager: Networkable {
    func fetchDataFromURL(url: URL) async throws -> Data {
        do {
            let(data, _) = try await URLSession.shared.data(from: url)
//            print(response)
            return data
        } catch {
            throw NetworkError.badUrl
        }
    }
}
