//
//  CurrencyListViewModel.swift
//  LBG_Virtusa-iOSTechTest
//
//  Created by kanagasabapathy on 13/10/23.
//

import Combine
import Foundation

@MainActor class CurrencyListViewModel: ObservableObject {
    typealias Currencies = [TableViewData]
    @Published var tableViewDataArray: Currencies = Currencies()
    @Published var error: NetworkError?
    @Published var selectedBaseCurrency: String = "EUR"
    @Published var enteredAmount: String = "1"

    private var cancellable = Set<AnyCancellable>()

    var tempTableViewDataArray: Currencies = Currencies()
    let locale: Locale? = Locale.current

    private let currencyListRepo: CurrencyListRepository
    init(currencyListRepo: CurrencyListRepository) {
        self.currencyListRepo = currencyListRepo
        setupSubscribers()
    }
}

extension CurrencyListViewModel {
    func setupSubscribers() {
        $enteredAmount.sink { [weak self] string in
            print("⌨️ Typed Amount", string)
            guard let unwrappedSelf = self, let amount = Double(string) else {
                return
            }
            unwrappedSelf.reactToEnteredAmount(amount)
        }.store(in: &cancellable)
        $selectedBaseCurrency.sink { [weak self] string in
            print("💰 Selected Currency", string)
            guard let unwrappedSelf = self else {
                return
            }
            unwrappedSelf.reactToSelectedCurrency(string)
        }.store(in: &cancellable)
    }
    func reactToEnteredAmount(_ amount: Double) {
      tableViewDataArray = tempTableViewDataArray
      self.tableViewDataArray =  currencyConvert(amount)
    }
    func reactToSelectedCurrency(_ currency: String) {
        Task {
            await fetchDataForCurrencies(baseURL: EndPoint.baseURL, accessKey: EndPoint.accessKey, base: currency)
        }
    }


    func fetchDataForCurrencies(baseURL: String, accessKey: String, base: String) async {
        let urlString = baseURL + accessKey + "/latest/\(base)"
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.error = .badUrl
            }
            return
        }
        do {
            let currencyData = try await currencyListRepo.fetchCurrencyList(for: url)
            _ = self.sortTableViewDataDetails(currencyData: currencyData)
            error = nil

        } catch {
            self.error = .generic
        }
    }
    func sortTableViewDataDetails(currencyData: CurrencyData) -> (Currencies) {
      let currencyDet = self.fetchAllCurrencyDetails()
      var arrayOfTableViewData: Currencies = Currencies()
      for (key, value) in currencyData.conversion_rates {
        guard let currencySymbol = currencyDet.filter({ $0.code.contains(key)}).last else {
          continue
        }
        guard let currencyName = locale?.localizedString(forCurrencyCode: key) else {
          continue
        }
        let tableViewData = TableViewData(base: self.selectedBaseCurrency,
                                          currencyCode: key,
                                          currencyName: currencyName,
                                          currencyValue: value,
                                          currencySymbol: currencySymbol.symbol)
        arrayOfTableViewData.append(tableViewData)
      }
      arrayOfTableViewData = arrayOfTableViewData.sorted(by: { tableViewData1, tableViewData2 in
        return (tableViewData1.currencyCode.localizedCaseInsensitiveCompare(tableViewData2.currencyCode) == .orderedAscending)
      })
      self.tempTableViewDataArray = arrayOfTableViewData
        DispatchQueue.main.async {
            self.tableViewDataArray = self.currencyConvert(Double(self.enteredAmount) ?? 1.0)
        }
      return arrayOfTableViewData
    }
    func currencyConvert(_ amount: Double) -> Currencies {
        let computedTableViewData = tempTableViewDataArray.map { data in
            return TableViewData(base: selectedBaseCurrency,
                                 currencyCode: data.currencyCode,
                                 currencyName: data.currencyName,
                                 currencyValue: data.currencyValue * amount,
                                 currencySymbol: data.currencySymbol)
          }
        return computedTableViewData
    }
    func fetchAllCurrencyDetails() -> [Currency] {
      var currencyDet: [Currency] = [Currency]()
      for localeID in Locale.availableIdentifiers {
        let locale = Locale(identifier: localeID)
        guard let currencyCode = locale.currency?.identifier, let currencySymbol = locale.currencySymbol else {
          continue
        }
        if !currencySymbol.validateGenericString(currencySymbol) {
          let filter = currencyDet.filter { $0.code.contains(currencyCode) }
          if filter.isEmpty {
            currencyDet.append(Currency(code: currencyCode, symbol: currencySymbol))
          }
        }
      }
      return currencyDet
    }
}

extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    mutating func advance(by value: Double) {
        self *= value
    }
}
