//
//  String+Extension.swift
//  LBG_Virtusa-iOSTechTest
//
//  Created by kanagasabapathy on 13/10/23.
//

import Foundation

extension String {
    func validateGenericString(_ string: String) -> Bool {
        return string.range(of: ".*[^A-Za-z0-9].*", options: .regularExpression) == nil
    }
    func countryFlag() -> String {
        return String(String.UnicodeScalarView(
            self.unicodeScalars.compactMap({ UnicodeScalar(127397 + $0.value)}
            )))
    }
}
