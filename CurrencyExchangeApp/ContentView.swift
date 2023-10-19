//
//  ContentView.swift
//  CurrencyExchangeApp
//
//  Created by Yağız Hitit on 15.10.2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var countriesVM = CurrencyViewModel()
    
    @State private var selectedCountry1 = ""
    @State private var selectedCountry2 = ""
    @State private var presentPicker1 = false
    @State private var presentPicker2 = false
    
    @State private var numberInput1 = ""
    @State private var numberInput2 = ""
    
    @State private var tag: Int = 0
    
    func currencyCodeFromCountryString(_ countryString: String) -> String? {
        let components = countryString.components(separatedBy: "(")
        guard components.count > 1 else { return nil }
        let code = components[1].trimmingCharacters(in: CharacterSet(charactersIn: " )"))
        return code
    }

    func convertCurrency() {
        guard let baseCode = countriesVM.getCodeForCountry(selectedCountry1),
              let targetCode = countriesVM.getCodeForCountry(selectedCountry2) else {
            return
        }
        
        print("Base Currency: \(baseCode)")
        print("Target Currency: \(targetCode)")
        print("Amount: \(numberInput1)")
        
        let urlString = "https://api.apilayer.com/exchangerates_data/latest?symbols=\(targetCode)&base=\(baseCode)"
        print("Generated URL: \(urlString)")
        
        countriesVM.fetchSpecificExchangeRate(baseCurrency: baseCode, targetCurrency: targetCode)
        
//        if let rate = countriesVM.getCurrentRate(for: targetCode),
//           let inputNumber = Double(numberInput1) {
//            numberInput2 = String(format: "%.2f", inputNumber * rate)
        //}
    }


    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color("Background")
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        
                        VStack {
                            TextField("Enter the amount", text: $countriesVM.inputValue)
                                .keyboardType(.numberPad)
                                .textFieldStyle(.plain)
                                .frame(width: 350, height: 50)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 44))
                            
                            Divider()
                                .frame(width: 350)
                            
                            CustomPickerTextView(presentPicker: $presentPicker1, fieldString: $selectedCountry1, placeholder: "Select a currency", tag: $tag, selectedTag: 1)

                        }
                        
                        VStack {
                            TextField("", text: $countriesVM.finalCurValue)
                                .textFieldStyle(.plain)
                                .frame(width: 350, height: 50)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 44))
                            
                            Divider()
                                .frame(width: 350)
                            
                            CustomPickerTextView(presentPicker: $presentPicker2, fieldString: $selectedCountry2, placeholder: "Select a currency", tag: $tag, selectedTag: 2)

                        }
                        
                        Spacer()
                        
                        Button(action: {
                            convertCurrency()
                        }) {
                            Text("Calculate")
                                .font(.title2)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        .padding(.bottom)
                        
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                    .navigationBarTitle("Currency Exchange", displayMode: .inline)
                }
                .background(Color("backgroundColor"))
            }
            if presentPicker1 {
                CustomPickerView(items: countriesVM.countryNamesArray, pickerField: $selectedCountry1, presentPicker: $presentPicker1)
            } else if presentPicker2 {
                CustomPickerView(items: countriesVM.countryNamesArray, pickerField: $selectedCountry2, presentPicker: $presentPicker2)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
