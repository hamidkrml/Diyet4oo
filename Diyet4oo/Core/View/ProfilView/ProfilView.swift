//
//  ProfilView.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import SwiftUI

/// Main profile view that displays daily meal tracking and navigation
struct ProfilView: View {
    // MARK: - Body
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    Spacer()
                    Divider()
                    
                    // Daily calorie tracking section
                    productSider()
                    
                    Spacer()
                    
                    // Meal navigation sections
                    mealNavigationSection(title: "Kahvaltı", image: "icon")
                    Divider()
                    
                    mealNavigationSection(title: "Öğle", image: "icon")
                    Divider()
                    
                    mealNavigationSection(title: "Akşam", image: "icon")
                    Divider()
                    
                    mealNavigationSection(title: "Ara Öğün", image: "icon")
                    Divider()
                }
                .padding(.horizontal)
            }
            .navigationTitle("Bugün")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    calendarButton
                }
            }
        }
    }
    
    // MARK: - UI Components
    
    /// Calendar button in the navigation bar
    private var calendarButton: some View {
        Button(action: {
            print("Takvim butonuna tıklandı")
        }) {
            Image(systemName: "calendar.and.person")
        }
    }
    
    /// Creates a navigation section for a meal
    private func mealNavigationSection(title: String, image: String) -> some View {
        NavigationLink {
            SearchView()
                .navigationBarBackButtonHidden()
        } label: {
            productCard(image: image, title: title)
        }
    }
}

// MARK: - Preview
#Preview {
    ProfilView()
}

/////MARK:- Tabardaki button ozeligi
//@ViewBuilder
//func calendarIconView() -> some View {
//    if #available(iOS 18.0, *) {
//        Image(systemName: "calendar.and.person")
//            .symbolEffect(.breathe.pulse.wholeSymbol, options: .repeat(.continuous))
//            .foregroundStyle(Color("Text"))
//    } else {
//        Image(systemName: "calendar.and.person")
//    }
//    /// yeni tab button eklense buraya eklenecek
//}
