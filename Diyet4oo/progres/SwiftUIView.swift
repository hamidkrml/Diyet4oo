import Foundation
import SwiftUI

class RegistrationViewModel: ObservableObject {
    // 1. @Published eklenmeli
    @Published var currentStep = 1
    let totalSteps = 3 // 2. Sabit olarak tanımla
    
    // 3. Kullanıcı verilerini ekle
    @Published var gender: String = ""
    @Published var birthDate = Date()
    @Published var height: Int = 170
    @Published var weight: Int = 70
    
    func nextStep() {
        guard currentStep < totalSteps else { return }
        currentStep += 1
    }
    
    func previousStep() {
        guard currentStep > 1 else { return }
        currentStep -= 1
    }
}
