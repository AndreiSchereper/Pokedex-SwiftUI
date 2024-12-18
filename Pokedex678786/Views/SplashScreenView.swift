import SwiftUI

struct SplashScreenView: View {
    // MARK: - Animation State Properties
    @State private var logoScale: CGFloat = 0.8 // Initial scale of the logo
    @State private var logoOpacity: Double = 0.5 // Initial opacity of the logo

    var body: some View {
        ZStack {
            // Background Color
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all) // Fill the entire screen

            // App Logo
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200) // Logo size
                .scaleEffect(logoScale) // Animation for scale
                .opacity(logoOpacity) // Animation for opacity
                .onAppear {
                    // Start animation when the view appears
                    withAnimation(.easeInOut(duration: 1.5)) {
                        logoScale = 1.0
                        logoOpacity = 1.0
                    }
                }
        }
    }
}

// MARK: - Preview
#Preview {
    SplashScreenView()
}
