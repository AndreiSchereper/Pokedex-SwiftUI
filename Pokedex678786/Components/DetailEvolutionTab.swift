import SwiftUI

/// Displays the Pokémon evolution chain in the detail view.
struct DetailEvolutionTab: View {
    let evolutionChain: [PokemonEvolution] // List of Pokémon in the evolution chain
    let currentPokemonID: Int // ID of the currently displayed Pokémon

    var body: some View {
        VStack(spacing: 24) { // Spacing between Pokémon and arrows
            ForEach(evolutionChain) { pokemon in
                VStack(spacing: 8) {
                    // Display a Pokémon card with navigation if it's not the current Pokémon
                    if pokemon.id != currentPokemonID {
                        NavigationLink(destination: DetailView(pokemonID: pokemon.id)) {
                            EvolutionCard(pokemon: pokemon) // Card component for the Pokémon
                        }
                        .buttonStyle(PlainButtonStyle()) // Removes default button tap effect
                    } else {
                        EvolutionCard(pokemon: pokemon) // Current Pokémon card (not clickable)
                    }

                    // Add an arrow between evolutions
                    if pokemon != evolutionChain.last {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 20)) // Arrow size
                            .foregroundColor(.gray) // Arrow color
                    }
                }
            }
        }
    }
}

/// A card that displays the image, name, and ID of a Pokémon in the evolution chain.
struct EvolutionCard: View {
    let pokemon: PokemonEvolution // Pokémon data for the card

    var body: some View {
        HStack(spacing: 16) { // Horizontal layout for the card content
            // Pokémon image
            AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                image.resizable().scaledToFit() // Resizable image scaled to fit its frame
            } placeholder: {
                ProgressView() // Loading indicator
            }
            .frame(width: 80, height: 80) // Set image size

            // Pokémon name and ID
            VStack(alignment: .leading, spacing: 4) {
                Text(pokemon.name.capitalized) // Capitalized Pokémon name
                    .font(.custom("Poppins-SemiBold", size: 16))
                    .foregroundColor(Color("TextColor")) // Text color from assets

                Text(String(format: "#%03d", pokemon.id)) // Display Pokémon ID in 3-digit format
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.gray) // Subdued gray for ID
            }

            Spacer() // Pushes content to the left
        }
        .padding() // Adds padding inside the card
        .background(
            RoundedRectangle(cornerRadius: 12) // Rounded card shape
                .fill(Color("CardColor")) // Background color from assets
                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4) // Subtle shadow for depth
        )
    }
}
