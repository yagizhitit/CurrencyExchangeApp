//
//  Currency.swift
//  CurrencyExchangeApp
//
//  Created by Yağız Hitit on 16.10.2023.
//

import Foundation

struct Currency: Identifiable, Codable {
    var id: UUID? = UUID()
    let name: String
    let code: String
    let flag: String
    let appStore: Bool
}
