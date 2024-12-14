import SwiftUI

@main
struct PokedexApp: App {
    @State private var showSplashScreen = true // Controls the splash screen display

    var body: some Scene {
        WindowGroup {
            ZStack {
                ContentView()
                    .opacity(showSplashScreen ? 0 : 1) // ContentView fades in
                    .animation(.easeInOut(duration: 1), value: showSplashScreen)

                if showSplashScreen {
                    SplashScreenView()
                        .transition(.opacity) // Smooth fade-out
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showSplashScreen = false
                                }
                            }
                        }
                }
            }
        }
    }
}
