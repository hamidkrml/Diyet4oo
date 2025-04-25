//
//  Boy .swift
//  Diyet4oo
//
//  Created by hamid on 25.04.2025.
//

import SwiftUI
struct Boy_: View {
    @State private var selectedHeight = 170
    let heights = Array(150...220)
    
    var body: some View {
        GeometryReader { geometry in
            // button boyutlandirmak icin 
            VStack {
                
                // picker boyutlandirmak icin
                VStack {
                    Picker("Boyunuzu Giriniz", selection: $selectedHeight) {
                        ForEach(heights, id: \.self) { hamit in
                            Text("\(hamit)")
                        }
                    }
                    Picker("Boyunuzu Giriniz", selection: $selectedHeight) {
                        ForEach(heights, id: \.self) { hamit in
                            Text("\(hamit)")
                        }
                        
                    }
                    
                }
                .pickerStyle(.inline)
                .frame(width: geometry.size.width * 0.6,height: geometry.size.height * 0.6)
                .padding(.top,geometry.size.height * 0.2)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 4)
                
                Spacer()
                Button("hamit"){}
                    
            }
            
           
            
        }
    }
}
#Preview {
    Boy_()
}
