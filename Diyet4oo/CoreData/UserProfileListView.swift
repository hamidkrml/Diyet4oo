import SwiftUI
import CoreData

struct UserProfileListView: View {
    @FetchRequest(
        entity: UserProfile.entity(),
        sortDescriptors: []
    ) var profiles: FetchedResults<UserProfile>
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView {
            List(profiles) { profile in
                VStack(alignment: .leading, spacing: 5) {
                    Text("Cinsiyet: \(profile.gender ?? "Bilinmiyor")")
                    Text("Doğum Günü: \(profile.birthDay)")
                    Text("Doğum Ayı: \(profile.birthMonth ?? "Bilinmiyor")")
                    Text("Doğum Yılı: \(profile.birthYear)")
                    Text("Boy: \(profile.height) cm")
                    Text("Kilo: \(profile.weight) kg")
                    Text("Hedef Kilo: \(profile.targetWeight) kg")
                    Text("Hedef Hafta: \(profile.targetWeeks)")
                }
            }
            .navigationTitle("Kayıtlı Profiller")
        }.toolbar { BackToolbarItem(dismiss: dismiss) }
    }
}
