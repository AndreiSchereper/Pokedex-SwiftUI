import SwiftUI
import SwiftData

@main
struct PokedexApp: App {
    @State private var showSplashScreen = true // Tracks whether the splash screen is visible

    var body: some Scene {
        WindowGroup {
            ZStack {
                // Main app content
                ContentView()
                    .opacity(showSplashScreen ? 0 : 1) // Fade in when splash screen disappears
                    .animation(.easeInOut(duration: 1), value: showSplashScreen)

                // Splash screen overlay
                if showSplashScreen {
                    SplashScreenView()
                        .transition(.opacity) // Smooth fade-out for the splash screen
                        .onAppear {
                            // Dismiss splash screen after a delay
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showSplashScreen = false
                                }
                            }
                        }
                }
            }
        }
        .modelContainer(for: FavoritePokemon.self) // Attach the model container for managing FavoritePokemon
    }
}
