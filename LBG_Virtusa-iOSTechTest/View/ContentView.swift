//
//  ContentView.swift
//  LBG_Virtusa-iOSTechTest
//
//  Created by kanagasabapathy on 13/10/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel: CurrencyListViewModel
    @State var isErrorOccured: Bool
    var body: some View {
        VStack {
            if viewModel.error != nil {
                ProgressView().alert(isPresented: $isErrorOccured){
                    Alert(title: Text(viewModel.error?.localizedDescription ?? "Error Occured"),message: Text("Something went wrong"),
                          dismissButton: .default(Text("Ok")))
                }
            } else {
                Text("Convert Currency").font(.title).bold()
                HStack {
                    TextField("Enter text", text: $viewModel.enteredAmount)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    Spacer()
                    Picker("Currency", selection: $viewModel.selectedBaseCurrency) {
                        Text(viewModel.selectedBaseCurrency).tag(viewModel.selectedBaseCurrency)
                        ForEach(viewModel.tableViewDataArray, id: \.self) {
                            Text($0.currencyCode).tag($0.currencyCode)
                        }
                    }
                    .pickerStyle(.menu)
                }
                .progressViewStyle(.circular)
                Spacer()
                CurrencyListView(tableViewData: $viewModel.tableViewDataArray)
            }
        }.task {
            await viewModel.fetchDataForCurrencies(
                baseURL: EndPoint.baseURL,
                accessKey:EndPoint.accessKey,
                base: viewModel.selectedBaseCurrency)
        }.refreshable {
            await viewModel.fetchDataForCurrencies(
                baseURL: EndPoint.baseURL,
                accessKey:EndPoint.accessKey,
                base: viewModel.selectedBaseCurrency)
        }
    }
}

#Preview {
    ContentView(viewModel: CurrencyListViewModel(currencyListRepo: CurrencyListRepository(networkManager: NetworkManager())), isErrorOccured: false)
}
