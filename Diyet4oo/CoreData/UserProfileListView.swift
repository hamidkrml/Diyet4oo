import SwiftUI
import CoreData

struct UserProfileListView: View {
    @FetchRequest(
           entity: Food.entity(),
           sortDescriptors: []
       ) var foods: FetchedResults<Food>
    
    
    @FetchRequest(
        entity: DailyIntake.entity(),
        sortDescriptors: []
    ) var profile: FetchedResults<DailyIntake>
    
    
    
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            List(foods, id: \.self) { food in
                VStack(alignment: .leading, spacing: 5) {
//                    Text("Cinsiyet: \(profile.gender ?? "Bilinmiyor")")
//                    Text("Doğum Günü: \(profile.birthDay)")
//                    Text("Doğum Ayı: \(profile.birthMonth ?? "Bilinmiyor")")
//                    Text("Doğum Yılı: \(profile.birthYear)")
//                    Text("Boy: \(profile.height) cm")
//                    Text("Kilo: \(profile.weight) kg")
//                    Text("Hedef Kilo: \(profile.targetWeight) kg")
//                    Text("Hedef Hafta: \(profile.targetWeeks)")
                    
//                    Text("hesaplanan \(profile1.dailyCalories)")
                    
                    Text("yemegin ismileri:\(food.name ?? "hamit")")
                    
                    
                }
            }
            .navigationTitle("Kayıtlı Profiller")
        }.toolbar { BackToolbarItem(dismiss: dismiss) }
    }
}
