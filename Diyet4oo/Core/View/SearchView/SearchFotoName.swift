//
//  SearchFotoName.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.
//
import SwiftUI

struct Searchuserfotoname: View {
 
    let food: Food

    var body: some View {
        HStack{
            Image(systemName: "swift")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
          
            VStack(alignment: .leading){
                Text(food.name ?? "cvbn")
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("ButtonC"))
                
                Text("\(Int(food.energy)) kcal")
                    .foregroundStyle(Color("ButtonC"))
                
            }
            
            .font(.footnote)
            Spacer()

            
        }
        .frame(height: 80)
        .padding(.horizontal)
    }
}
