//
//  MainPage.swift
//  WeSplit
//
//  Created by Natalie Ammerman on 10/3/24.
//

import SwiftUI

struct MainPage: View {
    @State private var amount: Double = 0
    @State private var peopleNum: Int = 1
    @State private var tip: String = "10%"
    @FocusState private var isFocused: Bool
    @Environment(\.colorScheme) var colorScheme
    
    var buttonColor: Color {
        return colorScheme == .dark ? .white : .black
    }
    
    let tips = ["10%", "15%", "20%", "25%", "0%"]
    
    var totalWithTip: Double {
        switch tip {
        case "10%":
            return amount * 1.1
        case "15%":
            return amount * 1.15
        case "20%":
            return amount * 1.2
        case "25%":
            return amount * 1.25
        default:
            return amount
        }
    }
    
    var amountPerPerson: Double {
        let peopleNum = max(1, peopleNum)
        return totalWithTip / Double(peopleNum)
    }
    
    var body: some View {
        NavigationStack() {
            Form() {
                Section() {
                    TextField("Amount", value: $amount, format: .number).keyboardType(.decimalPad).focused($isFocused)
                        .onTapGesture {
                            isFocused = true
                        }
                    TextField("Number of People", value: $peopleNum, format: .number).keyboardType(.numberPad)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip", selection: $tip) {
                        ForEach(tips, id: \.self) {
                            tip in Text(tip)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section("Check Total with Tip:") {
                    Text("$\(totalWithTip, specifier: "%.2f")")
                }
                Section("Amount per person:") {
                    Text("$\(amountPerPerson, specifier: "%.2f")")
                }
            }
            NavigationLink {
                SplitView()
            } label: {
                Text("Done").foregroundStyle(buttonColor)
            }
            .navigationTitle("WeSplit")
        }
    }
}

#Preview {
    MainPage()
}
