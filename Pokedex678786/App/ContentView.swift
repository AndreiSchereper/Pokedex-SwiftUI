import SwiftUI

/// Main view for the app, displaying a tab-based interface.
struct ContentView: View {
    var body: some View {
        TabView {
            // Tab for the Pokémon list (Pokedex)
            PokemonListView()
                .tabItem {
                    Label("Pokedex", systemImage: "house") // Tab icon and label
                }

            // Tab for the user's favorite Pokémon
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill") // Tab icon and label
                }
        }
        .accentColor(.red) // Highlight color for the selected tab
    }
}

#Preview {
    ContentView() // Preview for the ContentView in Xcode
}
