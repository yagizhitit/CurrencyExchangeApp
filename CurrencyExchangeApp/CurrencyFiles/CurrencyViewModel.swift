//
//  CurrencyViewModel.swift
//  CurrencyExchangeApp
//
//  Created by Yağız Hitit on 16.10.2023.
//

import Foundation

class CurrencyViewModel: NSObject, ObservableObject {
    @Published var currencies = [Currency]()
    
    var countryNamesArray:[String] {
        currencies.map{"\($0.flag) \($0.name)"}.sorted()
    }
    
    override init() {
        currencies = Store.retrieveCountries()
    }
}
