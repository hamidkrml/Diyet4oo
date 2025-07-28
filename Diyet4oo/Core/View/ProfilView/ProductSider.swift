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
    
    @State private var minValue = 0.0
    
    @FetchRequest(
        entity: DailyIntake.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "date == %@", Calendar.current.startOfDay(for: Date()) as NSDate)
    ) var profiles: FetchedResults<DailyIntake>
    
    var current: Double {
        Double(profiles.first?.caloriesTaken ?? 0)
    }
    // MARK: - Computed Properties
    var hedefKalori: Double {
        Double(profiles.first?.dailyCalories ?? 2000)
    }
    
    var kalanKalori: Double {
        let kalan = hedefKalori - current
        return kalan > 0 ? kalan : 0
    }

    var gaugeMaxValue: Double {
        max(hedefKalori, current)
    }
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 20) {
            Text("Kalori Takibi")
                .font(.headline)
                .padding(.top)
            
            // Kalori takip bölümü - TAM ORTALANMIŞ
            calorieTrackingSection
            
            Spacer()
            Divider()
            
            // Besin bilgileri bölümü - TAM ORTALANMIŞ
            nutritionInfoSection
                .padding(.bottom)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
        )
        .modifier(CardModifier())
        .padding(.vertical)
        .onAppear {
            // Eğer bugünün kaydı yoksa otomatik oluştur
            if profiles.first == nil {
                let context = CoreDataManager.shared.viewContext
                let daily = DailyIntake(context: context)
                daily.date = Calendar.current.startOfDay(for: Date())
                daily.dailyCalories = Int32(InputViewModel().gunlukKaloriIhtiyaci())
                do {
                    try context.save()
                } catch {
                    print("Bugünün kaydı oluşturulamadı: \(error)")
                }
            }
            // current değerini güncelle
            
        }
    }
    
    // MARK: - UI Components
    
    /// Kalori takip bölümü (gauge ile birlikte)
    private var calorieTrackingSection: some View {
        HStack {
            Spacer()
            
            // Alınan kalori bilgisi
            VStack {
                Text("\(Int(current))")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Alınan")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            // Kalori gauge
            calorieGauge
                .frame(width: 150, height: 150) // Sabit boyut
            
            Spacer()
            
            // Kalan kalori bilgisi
            VStack {
                Text("\(Int(kalanKalori))")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("Kalan")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding(.horizontal)
    }
    
    /// Besin bilgileri bölümü
    private var nutritionInfoSection: some View {
        HStack(spacing: 20) {
            nutritionInfoView(label: "Protein", value: "\(profiles.first?.proteinTaken ?? 0)g")
            nutritionInfoView(label: "Yağ", value: "\(profiles.first?.fatTaken ?? 0)g")
            nutritionInfoView(label: "Karbonhidrat", value: "\(profiles.first?.carbTaken ?? 0)g")
        }
        .padding(.horizontal)
    }
    
    /// Kalori gauge
    private var calorieGauge: some View {
        Gauge(value: current, in: minValue...gaugeMaxValue) {
            // Gauge başlık
            Text("Hedef: \(Int(hedefKalori))")
                .font(.caption)
        } currentValueLabel: {
            Text("\(Int(current))")
                .font(.title2)
                .fontWeight(.bold)
        } minimumValueLabel: {
            Text("\(Int(minValue))")
                .font(.caption)
        } maximumValueLabel: {
            Text("\(Int(gaugeMaxValue))")
                .font(.caption)
        }
        .gaugeStyle(CustomGaugeStyle(
            maxValue: gaugeMaxValue,
            textgir: "Kalan: \(Int(kalanKalori))",
            strokeColor: current > hedefKalori ? .red : .blue
        ))
    }
    
    /// Besin bilgisi görünümü
    private func nutritionInfoView(label: String, value: String) -> some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.footnote)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.body)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity)
    }
}

