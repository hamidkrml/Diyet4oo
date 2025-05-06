//
//  SearchFotoName.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.
//
import SwiftUI

struct Searchuserfotoname: View {
    let userfoto : String
    let username:String
    let useryorumu:String
    var body: some View {
        HStack{
            Image(systemName:userfoto)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
            
            Spacer()
            VStack(alignment: .leading){
                Text(username)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color("ButtonC"))
                
                Text(useryorumu)
                    .foregroundStyle(Color("ButtonC"))
                
            }
            
            .font(.footnote)
            Spacer()
        }
        .padding(.horizontal)
    }
}
