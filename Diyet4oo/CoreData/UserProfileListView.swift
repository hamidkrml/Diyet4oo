import SwiftUI
import CoreData

struct UserProfileListView: View {
    @FetchRequest(
        entity: UserProfile.entity(),
        sortDescriptors: [] // sıralama yok
    ) var profiles: FetchedResults<UserProfile>

    var body: some View {
        NavigationView {
            List(profiles) { profile in
                VStack(alignment: .leading, spacing: 5) {
                    Text("Cinsiyet: \(profile.gender ?? "Bilinmiyor")")
                    Text("Boy: \(profile.height) cm")
                    Text("Kilo: \(profile.weight) kg")
                   
                }
            }
            .navigationTitle("Kayıtlı Profiller")
        }
    }
}
