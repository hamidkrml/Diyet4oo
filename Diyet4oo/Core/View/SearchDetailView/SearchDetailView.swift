//
//  SearchDetailView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 8.05.2025.
//

import SwiftUI

struct SearchDetailView: View {
    let food: Food
    @Environment(\.managedObjectContext) private var context
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: SearchDetailViewModel

    init(food: Food) {
        self.food = food
        _viewModel = StateObject(wrappedValue: SearchDetailViewModel(context: CoreDataManager.shared.persistentContainer.viewContext))
    }

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20){
                    
                    HStack(spacing: 20){
                        SiderSearch(strokeColor: Color.blue, ici: "KarbonHidrat")
                        SiderSearch(strokeColor: Color.red, ici: "Protein")
                        SiderSearch(strokeColor: Color.green, ici: "Yağ")
                    }
                    
                    Text("\(food.name ?? "denen gelmedi" )")
                    StatCard(title: "Porsiyon", value: "\(food.portion)", unit: "adet", icon: "🍽️", color: Color.gray.opacity(0.5 ))
                    StatCard(title: "Karbonhidrat", value: "\(food.carb)", unit: "g", icon: "🍞", color: Color.blue.opacity(0.1))
                  
                    
                    StatCard(title: "Yağ", value: "\(food.fat)", unit: "g", icon: "🥑", color: Color.orange.opacity(0.2))
                  
                    StatCard(title: "Lif", value: "\(food.fiber ?? 0)", unit: "g", icon: "🌿", color: Color.green.opacity(0.2))
                    
                    
                    StatCard(title: "Şeker", value: "\(food.sugar ?? 0)", unit: "g", icon: "🍬", color: Color.pink.opacity(0.2))
                    
                    
                    StatCard(title: "Protein", value: "\(food.protein)", unit: "g", icon: "💪", color: Color.red.opacity(0.2))
                    
                    StatCard(title: "Enerji", value: "\(food.energy)", unit: "kcal", icon: "⚡️", color: Color.yellow.opacity(0.2))
                    Divider()
                    
                    PrimaryButton(title: "Yeni Ekle", icon: "dot.circle.and.hand.point.up.left.fill") {
                        viewModel.addFoodToTodayIntake(food: food)
                        dismiss()
                    }
                    
                    
                    
                }
            }.navigationTitle("Buraya kullanci sectigi yemegin adi gelecek ")
                .navigationBarTitleDisplayMode(.inline)
        }
        Spacer()
            .toolbar(.hidden, for: .tabBar)
    }
}
//
//#Preview {
//    SearchDetailView()
//}



struct StatCard: View {
    var title: String
    var subtitle: String? = nil
    var value: String
    var unit: String? = nil
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
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(Color("ButtonC"))
                }
            }
            
            Spacer()
            
            // Sağ taraf: değer ve birim
            VStack(alignment: .trailing, spacing: 4) {
                Text(value)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color("ButtonC"))
                if let unit = unit {
                    Text(unit)
                        .font(.caption)
                        .foregroundColor(Color("ButtonC"))
                }
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
