//
//  MainPage.swift
//  WeSplit
//
//  Created by Natalie Ammerman on 10/3/24.
//

import SwiftUI

struct MainPage: View {
    @State private var amount: Double = 0
    @State private var peopleNum: Int = 0
    @State private var tip: String = "10%"
    
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
        return totalWithTip / Double(peopleNum)
    }
    
    var body: some View {
        NavigationStack() {
            Form() {
                Section() {
                    TextField("Amount", value: $amount, format: .number)
                    TextField("Number of People", value: $peopleNum, format: .number)
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
            .navigationTitle("WeSplit")
        }
    }
}

#Preview {
    MainPage()
}
