//
//  CurrencyListView.swift
//  LBG_Virtusa-iOSTechTest
//
//  Created by kanagasabapathy on 13/10/23.
//

import SwiftUI

struct CurrencyListView: View {
    typealias Currencies = [TableViewData]
    @Binding var tableViewData: Currencies

    var body: some View {
        let allTableViewData = groupByCurrency(tableViewData).1
        let allKeys = groupByCurrency(tableViewData).0
        ScrollViewReader { scrollProxy in
            ZStack {
                List {
                    ForEach(allTableViewData, id: \.0) { pair in
                        Section(header: Text(pair.0)) {
                            ForEach(pair.1) { data in
                                CurrencyRowView(tableViewData: data)
                            }
                        }
                    }
                }.listStyle(.grouped)
                VStack {
                    ForEach(allKeys, id: \.self) { letter in
                        HStack {
                            Spacer()
                            Button(action: {
                                if tableViewData.first(where: { $0.currencyName.prefix(1) == letter }) != nil {
                                    withAnimation {
                                        scrollProxy.scrollTo(letter, anchor: .center)
                                    }
                                }
                            }, label: {
                                Text(letter)
                                    .font(.system(size: 12))
                                    .padding(.trailing, 7)
                            })
                        }
                    }
                }
            }
        }
    }
    func groupByCurrency(_ tableViewData: Currencies) -> ([String], [(String, Currencies)]) {
        let grouped = Dictionary(grouping: tableViewData, by: {
            String($0.currencyName.prefix(1))
        })
        return (grouped.keys.sorted(), grouped.sorted(by: {$0.key < $1.key}))
    }
}

#Preview {

    CurrencyListView(tableViewData: .constant([
        TableViewData(base: "EUR", currencyCode: "USD",currencyName: "Dollar",currencyValue: 1,currencySymbol: "$"),
        TableViewData(base: "EUR", currencyCode: "USD",currencyName: "Dollar",currencyValue: 1,currencySymbol: "$")]))
}
