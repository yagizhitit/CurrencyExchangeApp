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
