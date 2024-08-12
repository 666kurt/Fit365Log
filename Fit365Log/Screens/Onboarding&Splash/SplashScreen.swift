import SwiftUI

struct SplashScreen: View {
    
    @State private var progress: CGFloat = 0.0
    @State private var isActive: Bool = false
    @Binding var showOnboarding: Bool
    let persistenceController: PersistenceController
    
    var body: some View {
        ZStack {
            
            Color.theme.background.main.ignoresSafeArea()
            
            
            VStack(spacing: 100) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 15)
                        .foregroundColor(Color(hex: "#272727"))
                    Rectangle()
                        .frame(width: progress, height: 15)
                        .foregroundColor(Color.theme.text.second)
                        .animation(.linear(duration: 0.5), value: progress)
                }
                .cornerRadius(10)
                .padding(.horizontal, 50)
            }
            
        }
        .onAppear {
            startLoading()
        }
        .fullScreenCover(isPresented: $isActive) {
            if showOnboarding {
                OnboardingScreen(showOnboarding: $showOnboarding)
            } else {
                WelcomeScreen()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }
    
    func startLoading() {
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { timer in
            if progress < 300 {
                progress += 8
            } else {
                timer.invalidate()
                isActive = true
            }
        }
    }
}

#Preview {
    SplashScreen(showOnboarding: .constant(true),
                 persistenceController: PersistenceController.shared)
}
