//
//  Dogumyil.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI
struct DogumYiliInputView: View {
    @State private var selectedDay = 5
    @State private var selectedMonth = DateFormatter().monthSymbols[7] // Ağustos
    @State private var selectedYear = 2000
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 10) {
                    ProgressBarView(currentStep: 2, totalSteps: 3)
                    
                    
                    DatePickersView(
                        selectedDay: $selectedDay,
                        selectedMonth: $selectedMonth,
                        selectedYear: $selectedYear,
                        geometry: geometry
                    )
                    
                    Spacer()
                    
                    NavigationButton(destination: BoyKiloInputView())
                        .padding(.bottom)
                }
                .toolbar { BackToolbarItem(dismiss: dismiss) }
            }
        }
    }
}

// MARK: - Subviews


private struct DatePickersView: View {
    @Binding var selectedDay: Int
    @Binding var selectedMonth: String
    @Binding var selectedYear: Int
    let geometry: GeometryProxy
    
    private var months: [String] {
        DateFormatter().monthSymbols
    }
    
    private var days: [Int] {
        let date = Calendar.current.date(from: DateComponents(year: selectedYear, month: months.firstIndex(of: selectedMonth)! + 1))!
        return Array(1...Calendar.current.range(of: .day, in: .month, for: date)!.count)
    }
    
    private var years: [Int] {
        Array(1950...Calendar.current.component(.year, from: Date()))
    }
    
    var body: some View {
        VStack {
            Text("Dogum Tarihiniz")
                .font(.title2.bold())
                .padding(.top)
            HStack(spacing: geometry.size.width * 0.05) {
                WheelPicker(selection: $selectedDay, data: days, widthRatio: 0.1)
                WheelPicker(selection: $selectedMonth, data: months, widthRatio: 0.35)
                WheelPicker(selection: $selectedYear, data: years, widthRatio: 0.2)
            }
            .frame(height: geometry.size.height * 0.5)
            .padding(.top, geometry.size.height * 0.05)
        }
    }
}

private struct WheelPicker<T: Hashable>: View {
    @Binding var selection: T
    let data: [T]
    let widthRatio: CGFloat
    
    var body: some View {
        Picker("", selection: $selection) {
            ForEach(data, id: \.self) { item in
                Text("\(item)")
                    .tag(item)
            }
        }
        .pickerStyle(.wheel)
        .frame(width: UIScreen.main.bounds.width * widthRatio)
        .clipped()
    }
}


 
#Preview{
    DogumYiliInputView()
}
