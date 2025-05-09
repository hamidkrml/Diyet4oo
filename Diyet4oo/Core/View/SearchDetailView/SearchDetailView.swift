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
                        SiderSearch(strokeColor: Color.blue, ici: "KarbonHidrat")
                        SiderSearch(strokeColor: Color.red, ici: "Protein")
                        SiderSearch(strokeColor: Color.green, ici: "Yağ")
                    }
                    
                    Text("Besin Degerleri 🔥")
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥", color: Color.gray.opacity(0.5 ))
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥", color: Color.white.opacity(0.1))
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥", color: Color.gray.opacity(0.5 ))
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥", color: Color.white.opacity(0.1))
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥", color: Color.gray.opacity(0.5 ))
                    StatCard(title: "Kalori", subtitle: "Yakılan", value: "150", unit: "kcal", icon: "🔥", color: Color.white.opacity(0.1))
                    Divider()
                    
                    PrimaryButton(title: "Yeni Ekle", icon: "dot.circle.and.hand.point.up.left.fill") {
                        print("hesaplama burada yapilacak")
                    }
                    
                    
                    
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
    var color : Color
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
                        .foregroundColor(Color("ButtonC"))
                }
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(Color("ButtonC"))
            }
            
            Spacer()
            
            // Sağ taraf: değer ve birim
            VStack(alignment: .trailing, spacing: 4) {
                Text(value)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("ButtonC"))
                Text(unit)
                    .font(.caption)
                    .foregroundColor(Color("ButtonC"))
            }
        }
        .modifier(CardModifier1())
    }
}






struct CardModifier1: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.2))
                    .shadow(radius: 5)
            )
            .padding(.horizontal)
    }
}

