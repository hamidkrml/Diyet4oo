//
//  Onboarding.swift
//  Diyet4oo
//
//  Created by hamid on 27.04.2025.
//

import SwiftUI

struct Onboarding: View {
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                Spacer()
                Text("Diyet 4oo")
                    .font(.system(size: 50, weight: .light, design: .serif))
                    .foregroundColor(Color("OnboardingColor"))
                    .padding(.vertical,30.0)
                    .italic()
                    .underline()
                GroupBox(label:
                            GroupBoxBaslik()
                ) {
                    ScrollView(.vertical, showsIndicators: true) {
                        VStack {
                            Rectangle()
                                .frame(height: 2)
                            GroupBoxTanitimIcerigi()
                        }
                    }
                    .frame(height: 250)
                }
                .padding(.horizontal)
                Spacer()
                NavigationButton(destination: CinsiyetInputView())
              
                
            }
        }
        
    }
}

//#Preview {
//    Onboarding(hasSeenOnboarding: .constant(false))


struct GroupBoxBaslik: View {
    var body: some View {
        HStack(alignment: .center){
            Image("icon")
                .resizable()
                .frame(width: 45.0,height: 40.0)
            
            Text("Kilo Vermenin ")
                .font(.title3)
                .fontDesign(.serif)
            +
            Text("En Kolay Yolu")
                .font(.title2)
                .fontDesign(.serif)
                .foregroundColor(Color("OnboardingColor"))
        }
    }
}

struct GroupBoxTanitimIcerigi: View {
    var body: some View {
        HStack(alignment: .center){
            
            Image(systemName: "pencil.circle")
                .resizable()
                .frame(width: 50,height: 50)
                .padding(.vertical)
            Spacer()
            Text("I agree to the above terms")
            Spacer()
            
        }
    }
}
