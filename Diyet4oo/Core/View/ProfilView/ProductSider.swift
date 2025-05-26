//
//  ProductSider.swift
//  Diyet4oo
//
//  Created by hamid on 29.04.2025.
//

import SwiftUI

/// A view that displays daily calorie tracking with a gauge and nutrition information
struct ProductSider: View {
    // MARK: - Properties
    @State private var current = 0.0
    @State private var minValue = 0.0
    
    @FetchRequest(
        entity: DailyIntake.entity(),
        sortDescriptors: []
    ) var profiles: FetchedResults<DailyIntake>
    
    // MARK: - Computed Properties
    
    /// Target calories from user profile or default value
    var hedefKalori: Double {
        Double(profiles.first?.dailyCalories ?? 2000)
    }
    
    /// Remaining calories calculation
    var kalanKalori: Double {
        Double(min(current, hedefKalori - current))
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            Text("Kalori Takibi")
            
            // Calorie tracking section
            calorieTrackingSection
            
            Spacer()
            Divider()
            
            // Nutrition information section
            nutritionInfoSection
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
        )
        .modifier(CardModifier())
        .padding(.vertical)
    }
    
    // MARK: - UI Components
    
    /// Calorie tracking section with gauge
    private var calorieTrackingSection: some View {
        HStack(spacing: 20) {
            Spacer()
            
            calorieInfoView(value: "0", label: "Alinan")
            
            Spacer()
            
            calorieGauge
            
            Spacer()
            
            calorieInfoView(value: "0", label: "Alinan")
            
            Spacer()
        }
    }
    
    /// Nutrition information section
    private var nutritionInfoSection: some View {
        HStack(spacing: 60) {
            nutritionInfoView(label: "KarbonHidrat", value: "0")
            nutritionInfoView(label: "KarbonHidrat", value: "0")
            nutritionInfoView(label: "KarbonHidrat", value: "0")
        }
    }
    
    /// Calorie gauge
    private var calorieGauge: some View {
        Gauge(value: kalanKalori, in: minValue...hedefKalori) {
            // Empty gauge content
        } currentValueLabel: {
            Text("\(Int(current))")
        } minimumValueLabel: {
            Text("\(Int(minValue))")
        } maximumValueLabel: {
            Text("\(Int(hedefKalori))")
        }
        .gaugeStyle(CustomGaugeStyle(maxValue: hedefKalori, textgir: "Kalan Kcal", strokeColor: Color.blue))
    }
    
    /// Calorie information view
    private func calorieInfoView(value: String, label: String) -> some View {
        VStack {
            Text(value)
            Text(label)
        }
    }
    
    /// Nutrition information view
    private func nutritionInfoView(label: String, value: String) -> some View {
        VStack {
            Text(label)
                .font(.footnote)
            Text(value)
        }
    }
}

// MARK: - Preview
#Preview {
    ProductSider()
}
