//
//  ProductCard.swift
//  Diyet4oo
//
//  Created by hamid on 29.04.2025.
//

import SwiftUI

/// A card view that displays meal information and allows adding items
struct ProductCard: View {
    // MARK: - Özellikler
    let image: String
    let title: String
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .center) { // Dikey hizalamayı merkez yap
            // Sol içerik (Resim ve yazılar)
            HStack {
                // Resim kısmı
                Image(image)
                    .resizable()
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
//                    .padding(.leading)
                // Yazılar için dikey düzen
               
                VStack(alignment: .leading ,spacing: 4) {
                    
                    Text(title)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    Text("Önerilen Kcal")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.gray.opacity(0.6))
                }
                .padding(.leading)
                
                
                
            }
            
            Spacer()
            addButton
            

            // Ekleme butonu
            
        }
        .padding(.horizontal) // Yatay padding ekle
        .padding(.vertical, 10) // Dikey padding ayarla
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
        )
        .modifier(CardModifier())
    }
    
    // MARK: - UI Bileşenleri
    private var addButton: some View {
        Image(systemName: "plus")
            .resizable()
            .frame(width: 15, height: 15)
            .foregroundColor(.gray.opacity(0.9))
    }
}

// MARK: - Önizleme
#Preview {
    ProductCard(image: "icon", title: "Örnek Öğün")
}
