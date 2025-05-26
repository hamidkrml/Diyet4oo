//
//  ProductCard.swift
//  Diyet4oo
//
//  Created by hamid on 29.04.2025.
//

import SwiftUI

/// A card view that displays meal information and allows adding items
struct ProductCard: View {
    // MARK: - Properties
    let image: String
    let title: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            // Left content
            VStack {
                headerContent
                recommendedCaloriesText
            }
            
            Spacer()
            
            // Add button
            addButton
        }
        .padding(.leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.gray.opacity(0.2))
        )
        .modifier(CardModifier())
        .padding(.vertical)
    }
    
    // MARK: - UI Components
    
    /// Header content with image and title
    private var headerContent: some View {
        HStack {
            Image(image)
                .resizable()
                .clipShape(Circle())
                .frame(width: 40, height: 40)
            
            Spacer()
            
            Text(title)
                .font(.footnote)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
        }
    }
    
    /// Recommended calories text
    private var recommendedCaloriesText: some View {
        HStack {
            Text("Önerilen Kcal")
            Spacer()
        }
        .font(.footnote)
        .fontWeight(.semibold)
        .foregroundColor(.gray.opacity(0.6))
    }
    
    /// Add button
    private var addButton: some View {
        HStack {
            Spacer()
            Image(systemName: "plus")
                .resizable()
                .frame(width: 15, height: 15)
                .foregroundColor(.gray.opacity(0.9))
        }
        .padding(.trailing)
    }
}

// MARK: - Preview
#Preview {
    ProductCard(image: "icon", title: "Örnek Öğün")
}
