import SwiftUI
import SwiftData

/// Favorites Page displaying a grid of favorite Pokémon and allowing navigation to details.
struct FavoritesView: View {
    @Environment(\.modelContext) private var context // Access Swift Data context
    @Query(sort: \FavoritePokemon.id) var favorites: [FavoritePokemon] // Query all favorite Pokémon
    @State private var selectedPokemonID: Int? // Tracks the currently selected Pokémon ID for navigation

    // Define a two-column grid layout
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            VStack {
                if favorites.isEmpty {
                    // Display a message when no favorites exist
                    Text("No Favorites Yet")
                        .font(.custom("Poppins-SemiBold", size: 20))
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // Display favorite Pokémon in a grid
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(favorites) { favorite in
                                PokemonCardView(
                                    pokemon: Pokemon(
                                        name: favorite.name,
                                        url: "https://pokeapi.co/api/v2/pokemon/\(favorite.id)"
                                    )
                                )
                                .onTapGesture {
                                    selectedPokemonID = favorite.id // Set selected Pokémon ID for navigation
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    }
                }
            }
            .navigationTitle("Favorites") // Screen title
            .background(
                NavigationLink(
                    destination: DetailView(pokemonID: selectedPokemonID ?? 0), // Navigate to DetailView
                    tag: selectedPokemonID ?? 0,
                    selection: $selectedPokemonID
                ) {
                    EmptyView()
                }
                .hidden() // Hide the NavigationLink UI
            )
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all)) // Custom background color
        }
    }
}
