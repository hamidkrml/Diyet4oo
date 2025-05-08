//
//  ProductSider.swift
//  Diyet4oo
//
//  Created by hamid on 29.04.2025.
//

import SwiftUI


struct productSider:View{
    @State private var current = 0.0
    @State private var minValue = 0.0
    
    
    @FetchRequest(
        entity: DailyIntake.entity(),
        sortDescriptors: []
    ) var profiles: FetchedResults<DailyIntake>
    
    
    var hedefKalori: Double {
        Double(profiles.first?.dailyCalories ?? 2000) // örnek değer
    }

    
    
    // kullancidan gelen veri tabaninan secen current baglanacak yani hangi oggunu sectiyse onu kcal
    var kalanKalori: Double {
        Double(min(current, hedefKalori - current))
    }
    var body: some View{
        VStack(spacing: 20){
            
            Text("Kalori Takibi")
         
            
            HStack(spacing: 20){
                Spacer()
                VStack{
                    Text("0")
                    Text("Alinan")
                }
                Spacer()
                Gauge(value: kalanKalori, in: minValue...hedefKalori) {
                    
                        
                } currentValueLabel: {
                    Text("\(Int(current))")
                } minimumValueLabel: {
                    Text("\(Int(minValue))")
                } maximumValueLabel: {
                    Text("\(Int(hedefKalori))")
                }
                .gaugeStyle(CustomGaugeStyle(maxValue: hedefKalori, textgir: "Kalan Kcal"))
                Spacer()
                VStack{
                    Text("0")
                    Text("Alinan")
                }
                Spacer()
            }
            Spacer()
            Divider()
            HStack(spacing: 60){
                VStack {
                    Text("KarbonHidrat")
                        .font(.footnote)
                    Text("0")
                }
                VStack {
                    Text("KarbonHidrat")
                        .font(.footnote)
                    Text("0")
                }
                VStack {
                    Text("KarbonHidrat")
                        .font(.footnote)
                    Text("0")
                }
                

            }
            
        }
        .background(Color.white.opacity(0.2))
        .modifier(CardModifier())
        
    }
}
#Preview {
    productSider()
}
