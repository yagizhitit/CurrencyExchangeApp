//
//  Store.swift
//  CurrencyExchangeApp
//
//  Created by Yağız Hitit on 16.10.2023.
//

//import SwiftUI
//
//class Store {
//    static let bundleURL = Bundle.main.url(forResource: "finalCountries.json", withExtension: nil)!
//
//    static func retrieveCountries() -> [Currency] {
//        let decoder = JSONDecoder()
//        guard let data = try? Data(contentsOf: bundleURL) else {
//            fatalError("Unable to load country data")
//        }
//        guard let countries = try? decoder.decode([Currency].self, from: data) else {
//            fatalError("Failed to decode JSON from the data")
//        }
//        return countries
//    }
//}

import SwiftUI

class Store {
    static let bundleURL = Bundle.main.url(forResource: "finalCountries.json", withExtension: nil)!
    
    static func retrieveCountries() -> [Currency] {
        let decoder = JSONDecoder()
        guard let data = try? Data(contentsOf: bundleURL) else {
            fatalError("Unable to load country data")
        }

        var countries: [Currency] = []
        do {
            countries = try decoder.decode([Currency].self, from: data)
        } catch {
            print("Decoding error: \(error)")
        }

        return countries
    }
}
