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
    
    var countryNamesArray: [String] {
        currencies.map { "\($0.flag) \($0.name) (\($0.currency.code ?? "Unknown"))" }.sorted()
    }
    
    override init() {
        currencies = Store.retrieveCountries()
        super.init()
        fetchExchangeRates()
    }
    
    func fetchExchangeRates() {
        // Opsiyonel olmayan değerlere sahip currency kodlarına filtreleme işlemi
        let nonOptionalCurrencyCodes = self.currencies.compactMap { $0.currency.code }
        
        let urlString = "https://api.apilayer.com/exchangerates_data/latest?symbols=\(nonOptionalCurrencyCodes.joined(separator: ","))&base=USD"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            return
        }
        
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.httpMethod = "GET"
        request.addValue("3rYeJF1etcelsHMG9BKriNI5VX0yW1s7", forHTTPHeaderField: "apikey")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(ExchangeRateResponse.self, from: data)
                DispatchQueue.main.async {
                    self.exchangeRates = decodedResponse.rates
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }

}

struct ExchangeRateResponse: Codable {
    let rates: [String: Double]
}
