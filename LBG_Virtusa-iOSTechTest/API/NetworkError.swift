//
//  NetworkError.swift
//  LBG_Virtusa-iOSTechTest
//
//  Created by kanagasabapathy on 13/10/23.
//

import Foundation

fileprivate struct Constants {
    static let badUrl = "Sorry, this URL is not valid"
    static let mapping = "Error raised, while mapping data"
    static let generic = "Sorry, try again later"
}

enum NetworkError: Equatable {
    case badUrl
    case mapping
    case generic
}

extension NetworkError: Error {
    var errorDescription: String {
        switch self  {
        case .badUrl:
            return Constants.badUrl
        case .generic:
            return Constants.generic
        case .mapping:
            return Constants.mapping
        }
    }
}
