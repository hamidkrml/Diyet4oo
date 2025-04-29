//
//  ProfilView.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import SwiftUI
struct ProfilView:View {
    var body: some View {
       
        ScrollView {
            VStack{
                Spacer()
                Divider()
                productSider()
                Divider()
                productCard(image: "icon", title: "Kahvalti")
                Divider()
                productCard(image: "icon", title: "Öğle Yemeği")
                Divider()
                
                productCard(image: "icon", title: "Akşam Yemeği")
                Divider()
                productCard(image: "icon", title: "Ara Ögün")
                Divider()
                
            }
        }
        
    }
}

#Preview{
    ProfilView()
}

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        
            .cornerRadius(10)
            .shadow(color:Color.green.opacity(0.65), radius: 10, x: 0, y: 5)
    }
}



struct productSider:View{
    @State private var current = 60.0
    @State private var minValue = 0.0
    @State private var maxValue = 100.0
    var body: some View{
        VStack(spacing: 20){
            
//            Text("Kalori Takibi")
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

struct CustomGaugeStyle: GaugeStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            
            Text("Kalori Takibi")
            ZStack {
                Circle()
                    .trim(from: 0.0, to: CGFloat(configuration.value))
                    .stroke(Color.blue, lineWidth: 8)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(configuration.value * 100))")
                    .font(.title2)
                    .bold()
            }
            .frame(width: 100, height: 100)
            
            
        }
    }
}









struct productCard: View {
    var image : String
    var title : String
    
    var body: some View {
        
        VStack{
            HStack{
                
                HStack {
                    Image(image)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 70,height: 70)
                    Spacer()
                    Text(title)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                        .padding()
                    Spacer()
                }
                Spacer()
                Image(systemName:"plus")
                    .resizable()
                    .frame(width: 30,height: 30)
                
            }
            .padding(.horizontal)
            
            
            VStack(spacing: 10) {
                HStack{
                    Text("Önerilen")
                        .font(.callout)
                    Spacer()
                }
                HStack{
                    
                    Text("8000 kcal")
                        .font(.footnote)
                    Spacer()
                    
                }
                
                
            }
            
            
            
            
        }
        .padding(.leading)
        .background(Color.white.opacity(0.2))
        .modifier(CardModifier())
    }
}

