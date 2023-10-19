//
//  CurrencyViewModel.swift
//  CurrencyExchangeApp
//
//  Created by Yağız Hitit on 16.10.2023.
//

import Foundation

class CurrencyViewModel: NSObject, ObservableObject {
    
    @Published var currencies = [Currency]()
    @Published var exchangeRates: [String: Double] = [:]
    
    var onExchangeRatesUpdated: (() -> Void)?
    
    var countryNamesArray: [String] {
        let uniqueCurrencies = Array(Set(currencies.map { "\($0.flag) \($0.name) (\($0.currency.code ?? "Unknown"))" }))
        return uniqueCurrencies.sorted()
    }

    override init() {
        currencies = Store.retrieveCountries()
        super.init()
        fetchInitialExchangeRates()
    }
    
    func fetchInitialExchangeRates() {
        let nonOptionalCurrencyCodes = self.currencies.compactMap { $0.currency.code }
        let urlString = "https://api.apilayer.com/exchangerates_data/latest?symbols=\(nonOptionalCurrencyCodes.joined(separator: ","))&base=USD"
        fetchExchangeRates(from: urlString)
    }

    func getExchangeRate(from baseCurrency: String, to targetCurrency: String) -> Double? {
        return exchangeRates["\(baseCurrency)_\(targetCurrency)"]
    }
    
    func fetchSpecificExchangeRate(baseCurrency: String, targetCurrency: String) {
        let urlString = "https://api.apilayer.com/exchangerates_data/latest?symbols=\(targetCurrency)&base=\(baseCurrency)"
        fetchExchangeRates(from: urlString)
    }
    
    func getCurrentRate(for currencyCode: String) -> Double? {
        return exchangeRates[currencyCode]
    }
    
    private func fetchExchangeRates(from urlString: String) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("3rYeJF1etcelsHMG9BKriNI5VX0yW1s7", forHTTPHeaderField: "apikey")  // Not: API anahtarınızı bu şekilde saklamamanızı öneririm!
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                DispatchQueue.main.async {
                    self.exchangeRates = decodedResponse.rates
                    self.onExchangeRatesUpdated?()
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func getCodeForCountry(_ countryDetail: String) -> String? {
        let components = countryDetail.components(separatedBy: "(")
        guard components.count > 1 else { return nil }
        let code = components[1].trimmingCharacters(in: CharacterSet(charactersIn: " )"))
        return code
    }
}

struct ExchangeRateResponse: Codable {
    let rates: [String: Double]
}

