//
//  ProductCard.swift
//  Diyet4oo
//
//  Created by hamid on 29.04.2025.
//

import SwiftUI

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
