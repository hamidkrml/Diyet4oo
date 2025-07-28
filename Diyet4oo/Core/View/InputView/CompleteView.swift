//
//  CompleteView.swift
//  Diyet4oo
//
//  Created by hamid on 26.04.2025.
//

import SwiftUI
struct CompleteView: View {
    @EnvironmentObject var viewModel: InputViewModel
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    @State private var isLoading = false
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                if isLoading {
                    ProgressView()
                        .padding()
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button("Verileri Kaydet ve Kaloriyi Hesapla") {
                    guard !isLoading else { return}
                    isLoading = true
                    errorMessage = nil

                    DispatchQueue.global(qos: .userInitiated).async {
                        viewModel.calculateDailyCalorieNeeds()
                        DispatchQueue.main.async {
                            viewModel.saveDailyCalorieTarget() // Ana thread'de çağır!
                            do {
                                CoreDataManager.shared.completeOnboarding()
                                appState.showOnboarding = false
                            } catch {
                                errorMessage = "Kayıt işlemi başarısız oldu: \(error.localizedDescription)"
                                isLoading = false
                            }
                        }
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(isLoading)
                .padding()
                
                NavigationLink(destination: MainTabView()) {
                    Text("Ana Sayfaya Git")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
            }
            .navigationBarTitle("Kayıt Tamamlandı", displayMode: .inline)
        }
        .toolbar { BackToolbarItem(dismiss: dismiss) }
    }
}
