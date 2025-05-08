//
//  SearchDetailView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 8.05.2025.
//

import SwiftUI

struct SearchDetailView: View {
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20){
                    
                    HStack(spacing: 20){
                        SiderSearch(ici: "KarbonHidrat")
                        SiderSearch(ici: "Protein")
                        SiderSearch(ici: "Yağ")
                    }
                    
                    Text("Besin Degerleri 🔥")
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥")
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥")
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥")
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥")
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥")
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥")
                }
            }.navigationTitle("Buraya kullanci sectigi yemegin adi gelecek ")
                .navigationBarTitleDisplayMode(.inline)
        }
        Spacer()
    }
}

#Preview {
    SearchDetailView()
}



struct StatCard: View {
    var title: String
    var subtitle: String
    var value: String
    var unit: String
    var icon: String? = nil // opsiyonel emoji veya SF Symbol

    var body: some View {
        HStack {
            // Sol taraf: başlık ve açıklama
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    if let icon = icon {
                        Text(icon)
                    }
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                }
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }

            Spacer()

            // Sağ taraf: değer ve birim
            VStack(alignment: .trailing, spacing: 4) {
                Text(value)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                Text(unit)
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.7))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.blue)
                .shadow(radius: 5)
        )
        .padding(.horizontal)
    }
}
