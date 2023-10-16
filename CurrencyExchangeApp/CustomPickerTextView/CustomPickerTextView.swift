//
//  CustomPickerTextView.swift
//  CurrencyExchangeApp
//
//  Created by Yağız Hitit on 16.10.2023.
//

import SwiftUI

struct CustomPickerTextView: View {
    @Binding var presentPicker: Bool
    @Binding var fieldString: String
    var placeholder: String
    @Binding var tag: Int
    var selectedTag: Int
    var body: some View {
        TextField(placeholder, text: $fieldString).disabled(true)
            .font(.system(size: 22))
            .padding(.bottom,20)
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .frame(width: 400, height: 80)
            .overlay(
                Button(action: {
                    tag = selectedTag
                    withAnimation {
                        presentPicker = true
                    }
                }) {
                    Rectangle().foregroundColor((Color.clear))
                }
            )
    }
}
