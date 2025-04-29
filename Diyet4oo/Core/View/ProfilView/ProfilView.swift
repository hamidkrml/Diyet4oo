//
//  ProfilView.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import SwiftUI
struct ProfilView:View {
    var body: some View {
        VStack{
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

struct productCard: View {
    var image : String
    var title : String
    
    var body: some View {
        ScrollView {
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
}

