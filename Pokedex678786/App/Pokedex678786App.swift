import SwiftUI

@main
struct PokedexApp: App {
    @State private var showSplashScreen = true // Controls the visibility of the splash screen

    var body: some Scene {
        WindowGroup {
            ZStack {
                // Main content view for the app
                ContentView()
                    .opacity(showSplashScreen ? 0 : 1) // Fade in the ContentView when the splash screen disappears
                    .animation(.easeInOut(duration: 1), value: showSplashScreen)

                // Splash screen display
                if showSplashScreen {
                    SplashScreenView()
                        .transition(.opacity) // Smooth fade-out effect for the splash screen
                        .onAppear {
                            // Hide the splash screen after a 2-second delay
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
