//
//  SearchView.swift
//  Diyet4oo
//
//  Created by hamid karimli on 6.05.2025.
//

import SwiftUI
import SwiftUI

struct SearchView: View {
    @State private var arama: String = ""
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack {
                    ForEach(0...10, id: \.self) { _ in
                        Searchuserfotoname(userfoto: "swift", username: "ekmek", useryorumu: "360kcl")
                    }
                }
                .searchable(text: $arama, prompt: "yemekler")
            }
            .navigationTitle("Yemekler")
            .toolbar {
                BackToolbarItem(dismiss: dismiss)
            }
        }
    }
}

#Preview {
    SearchView()
}
