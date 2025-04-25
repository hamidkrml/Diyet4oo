
//import SwiftUI
//struct ContentView1: View {
//    @StateObject var progressManager = ProgressManager()
//    
//    var body: some View {
//        NavigationStack {
//            ZStack(alignment: .top) {
//                // Sayfa içerikleri
//                Group {
//                    switch progressManager.currentStep {
//                    case 1: CinsiyetInputView()
//                    case 2: DogumYiliInputView()
//                    case 3: BoyKiloInputView()
//                    default: EmptyView()
//                    }
//                }
//                .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading)))
//                
//                // Progress Bar (Tüm sayfalarda sabit)
//                ProgressBarView()
//                    .padding(.top, 10)
//            }
//            .environmentObject(progressManager)
//        }
//    }
//}
