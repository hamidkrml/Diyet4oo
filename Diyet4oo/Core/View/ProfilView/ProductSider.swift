//
//  ProductSider.swift
//  Diyet4oo
//
//  Created by hamid on 29.04.2025.
//

import SwiftUI


struct productSider:View{
    @State private var current = 10.0
    @State private var minValue = 0.0
    @State private var maxValue = 200.0
    
    
    @FetchRequest(
        entity: UserProfile.entity(),
        sortDescriptors: []
    ) var profiles: FetchedResults<UserProfile>
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
                Gauge(value: current, in: minValue...maxValue) {
                    
                        
                } currentValueLabel: {
                    Text("\(Int(current))")
                } minimumValueLabel: {
                    Text("\(Int(minValue))")
                } maximumValueLabel: {
                    Text("\(Int(maxValue))")
                }
                .gaugeStyle(CustomGaugeStyle())
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
