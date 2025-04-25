//
//  Dogumyil.swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI
struct Dogumyil: View {
    @State private var selectedDay = 5
    @State private var selectedMonth = "Ağustos"
    @State private var selectedYear = 2000

    let days = Array(1...31)
    let months = ["Ocak", "Şubat", "Mart", "Nisan", "Mayıs", "Haziran", "Temmuz", "Ağustos", "Eylül", "Ekim", "Kasım", "Aralık"]
    let years = Array(1950...2025)
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Text("Doğum tarihin?")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, geometry.size.height * 0.05)

                    HStack(spacing: geometry.size.width * 0.05) {
                        Picker(selection: $selectedDay, label: Text("")) {
                            ForEach(days, id: \.self) { day in
                                Text("\(day)").tag(day)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: geometry.size.width * 0.1)
                        .clipped()

                        Picker(selection: $selectedMonth, label: Text("")) {
                            ForEach(months, id: \.self) { month in
                                Text(month).tag(month)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: geometry.size.width * 0.35)
                        .clipped()

                        Picker(selection: $selectedYear, label: Text("")) {
                            ForEach(years, id: \.self) { year in
                                Text("\(year)").tag(year)
                            }
                        }
                        .pickerStyle(.wheel)
                        .frame(width: geometry.size.width * 0.2)
                        .clipped()
                    }
                    .frame(height: geometry.size.height * 0.5)
                    .padding(.top, geometry.size.height * 0.15)

                    Spacer()

                    NavigationLink {
                        Boy()
                            .navigationBarBackButtonHidden()
                    } label: {
                        ButtonCompenet(tiitle: "Devam")
                    }
                    .padding(.bottom)
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
}

#Preview {
    Dogumyil()
}
