//
//  ContentView.swift
//  CurrencyExchangeApp
//
//  Created by Yağız Hitit on 15.10.2023.
//

import SwiftUI

struct ContentView: View {
    
   @State private var food = ""
    var foodArray = ["Milk", "Apples", "Sugar", "Eggs", "Oranges", "Potatoes", "Corn", "Bread"]
    @StateObject private var countriesVM = CurrencyViewModel()
    @State private var country = ""
    @State private var presentPicker = false
    @State private var tag: Int = 1
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color("Background")
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        CustomPickerTextView(presentPicker: $presentPicker, fieldString: $food, placeholder: "Select a food item", tag: $tag, selectedTag: 1)
                        CustomPickerTextView(presentPicker: $presentPicker, fieldString: $country, placeholder: "Select a country", tag: $tag, selectedTag: 2)
                        Spacer()
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                    .navigationBarTitle("Picker Demo")
                }
            }
            if presentPicker {
                if tag == 1 {
                    CustomPickerView(items: foodArray.sorted(), pickerField: $food, presentPicker: $presentPicker)
                } else {
                    CustomPickerView(items: countriesVM.countryNamesArray, pickerField: $country, presentPicker: $presentPicker)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


