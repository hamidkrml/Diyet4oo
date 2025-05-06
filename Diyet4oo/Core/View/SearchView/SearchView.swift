//
//  SearchView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        NavigationView{
            ScrollView{
                LazyVStack{
                    ForEach(0...10,id: \.self){ _ in
                        Searchuserfotoname(userfoto: "swift", username: "ekmek", useryorumu: "360kcl")
                    }
                }
            }
            .navigationTitle("Yemekler")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SearchView()
}
