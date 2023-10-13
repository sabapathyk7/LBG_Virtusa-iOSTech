//
//  CurrencyRowView.swift
//  LBG_Virtusa-iOSTechTest
//
//  Created by kanagasabapathy on 13/10/23.
//

import SwiftUI

struct CurrencyRowView: View {
    @State var tableViewData: TableViewData

    var body: some View {
        HStack(alignment: .bottom) {
          VStack(alignment: .leading) {
            Text(tableViewData.currencyName ).font(.caption)
            Text(tableViewData.currencyCode + tableViewData.currencyCode.dropLast().description.countryFlag()).font(.subheadline).bold()
          }
          Spacer()
          Text(String(format: "%.2f", tableViewData.currencyValue.rounded(toPlaces: 2))).font(.headline)
        }
        .padding()
    }
}

#Preview {  
    CurrencyRowView(tableViewData: TableViewData(base: "EUR",currencyCode: "EUR",
                                                 currencyName: "Euro",
                                                 currencyValue: 10.222,
                                                 currencySymbol: "$"))
}
