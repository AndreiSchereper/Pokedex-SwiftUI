import SwiftUI
import SwiftData

/// Favorites Page displaying a grid of favorite Pokémon and allowing navigation to details.
struct FavoritesView: View {
    @Environment(\.modelContext) private var context // Access Swift Data context for managing favorites
    @Query(sort: \FavoritePokemon.id) var favorites: [FavoritePokemon] // Query all favorite Pokémon sorted by ID
    @State private var selectedPokemonID: Int? // Tracks the currently selected Pokémon ID for navigation

    // Define a two-column grid layout for the favorites
    private let columns = [
        GridItem(.flexible()), // Flexible column 1
        GridItem(.flexible())  // Flexible column 2
    ]

    var body: some View {
        NavigationView {
            ZStack {
                // Background color for the entire view
                Color("BackgroundColor")
                    .edgesIgnoringSafeArea(.all)

                if favorites.isEmpty {
                    // Show a message when there are no favorites
                    Text("No Favorites Yet")
                        .font(.custom("Poppins-SemiBold", size: 20))
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    // Display favorites in a grid
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(favorites) { favorite in
                                PokemonCardView(
                                    pokemon: Pokemon(
                                        name: favorite.name, // Pokémon name
                                        url: "https://pokeapi.co/api/v2/pokemon/\(favorite.id)" // Pokémon sprite URL
                                    )
                                )
                                .onTapGesture {
                                    // Navigate to the Pokémon's details when tapped
                                    selectedPokemonID = favorite.id
                                }
                            }
                        }
                        .padding(.horizontal, 16) // Horizontal padding for grid
                        .padding(.top, 8)         // Top padding for grid
                    }
                }
            }
            .navigationTitle("Favorites") // Title for the navigation bar
            .background(
                NavigationLink(
                    destination: DetailView(pokemonID: selectedPokemonID ?? 0), // Navigate to the detail view
                    tag: selectedPokemonID ?? 0,
                    selection: $selectedPokemonID
                ) {
                    EmptyView() // Invisible NavigationLink
                }
                .hidden() // Hide the NavigationLink from the UI
            )
        }
    }
}
