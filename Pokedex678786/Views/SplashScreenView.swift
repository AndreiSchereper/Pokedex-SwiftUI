import SwiftUI

struct SplashScreenView: View {
    @State private var logoScale: CGFloat = 0.8
    @State private var logoOpacity: Double = 0.5

    var body: some View {
        ZStack {
            Color("BackgroundColor") // Adaptive background color
                .edgesIgnoringSafeArea(.all)

            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200) // Adjust size as needed
                .scaleEffect(logoScale)
                .opacity(logoOpacity)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.5)) {
                        logoScale = 1.0
                        logoOpacity = 1.0
                    }
                }
        }
    }
}
