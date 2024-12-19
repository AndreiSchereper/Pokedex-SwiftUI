import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            PokemonListView()
                .tabItem {
                    Label("Pokedex", systemImage: "house")
                }

            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
        .accentColor(.red) // Highlight color for the selected tab
    }
}

// Placeholder for the Favorites Page
struct FavoritesPageView: View {
    var body: some View {
        ZStack {
            Color("BackgroundColor").edgesIgnoringSafeArea(.all)
            Text("Favorites Page")
                .font(.largeTitle)
                .foregroundColor(Color("TextColor"))
        }
    }
}

#Preview {
    ContentView()
}
