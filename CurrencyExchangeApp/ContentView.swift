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
    @State private var selectedCountry1 = ""
    @State private var selectedCountry2 = ""
    @State private var presentPicker1 = false
    @State private var presentPicker2 = false
    @State private var tag1: Int = 1
    @State private var tag2: Int = 2
    
    @State private var numberInput1 = ""
    @State private var numberInput2 = ""
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    Color("Background")
                        .edgesIgnoringSafeArea(.all)
                    VStack {
                        Spacer()
                        
                        VStack {
                            TextField("Enter the amount", text: $numberInput1)
                                .textFieldStyle(.plain)
                                .frame(width: 350, height: 50)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 44))
                            
                            Divider()
                                .frame(width: 350)
                            
                            CustomPickerTextView(presentPicker: $presentPicker1, fieldString: $selectedCountry1, placeholder: "Select a currency", tag: $tag1, selectedTag: 1)
                        }
                        
                        HStack {
                            VStack {
                                Rectangle()
                                    .fill(Color("firstColor"))
                                    .frame(width: 280,height: 1)
                                
                            }
                            
                            Button(action: {
                                
                            }) {
                                Image(systemName: "arrow.up.arrow.down.circle.fill")
                                    .font(.largeTitle)
                                    .foregroundColor(Color("firstColor"))
                                    .padding(.leading, 10)
                            }
                        }
                        .padding(.top, 80)
                        .padding(.bottom, 80)
                        
                        VStack {
                            TextField("", text: $numberInput2)
                                .textFieldStyle(.plain)
                                .frame(width: 350, height: 50)
                                .multilineTextAlignment(.trailing)
                                .font(.system(size: 44))
                            
                            Divider()
                                .frame(width: 350)
                            
                            CustomPickerTextView(presentPicker: $presentPicker2, fieldString: $selectedCountry2, placeholder: "Select a currency", tag: $tag2, selectedTag: 2)
                        }
                        Spacer()
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


