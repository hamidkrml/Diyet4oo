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
        
        HStack{
            VStack{
                
                HStack {
                    Image(image)
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 40,height: 40)
                    Spacer()
                    Text(title)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                    
                }
                HStack {
                    Text("Önerilen Kcal")
                    Spacer()
                }
                .font(.footnote)
                .fontWeight(.semibold)
                .foregroundColor(.gray.opacity(0.6))
            }
            Spacer()
            HStack{
                Spacer()
                Image(systemName:"plus")
                    .resizable()
                    .frame(width: 15,height: 15)
                    .foregroundColor(.gray.opacity(0.9))
                
            }
            .padding(.trailing)
        }
        .padding(.leading)
        .background(Color.white.opacity(0.2))
        .modifier(CardModifier())
    }
}
