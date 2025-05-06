//
//  Dogumyil.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI
struct DogumYiliInputView: View {
    
    
    
    
    var coreData = CoreDataManager.shared
    
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var ViewModel: InputViewModel
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    ProgressBarView(currentStep: 2, totalSteps: 4)
                    
                    Spacer()
                    DatePickersView(
                        selectedDay: $ViewModel.selectedDay,
                        selectedMonth: $ViewModel.selectedMonth,
                        selectedYear: $ViewModel.selectedYear,
                        geometry: geometry
                    )
                    
                    Spacer()
                    
                    NavigationButton(destination: BoyKiloInputView()
                        .environmentObject(ViewModel))
                    .padding(.bottom)
                    
                    .onAppear{
                        print("mkgfkmsd")
                        coreData.initializeData()
                    }
                    
                    
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
    
    var days: [Int] {
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
            
            HStack(spacing: geometry.size.height * 0.08) {
                WheelPicker(selection: $selectedDay, data: days, widthRatio: 0.18)
                WheelPicker(selection: $selectedMonth, data: months, widthRatio: 0.35)
                WheelPicker(selection: $selectedYear, data: years, widthRatio: 0.2)
            }
            
        }
        .frame(height: geometry.size.height * 0.5)
        //        .padding(.top, geometry.size.height * 0.07)
        
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
