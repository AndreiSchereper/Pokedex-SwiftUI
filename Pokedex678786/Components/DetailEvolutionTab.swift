import SwiftUI

struct DetailEvolutionTab: View {
    let evolutionChain: [PokemonEvolution]
    let currentPokemonID: Int // ID of the currently displayed Pokémon

    var body: some View {
        VStack(spacing: 24) { // Increased spacing to fit arrows better
            ForEach(evolutionChain) { pokemon in
                VStack(spacing: 8) {
                    // Pokémon Card (with navigation if not the current Pokémon)
                    if pokemon.id != currentPokemonID {
                        NavigationLink(destination: DetailView(pokemonID: pokemon.id)) {
                            EvolutionCard(pokemon: pokemon)
                        }
                        .buttonStyle(PlainButtonStyle()) // Removes default button tap effect
                    } else {
                        EvolutionCard(pokemon: pokemon) // Current Pokémon is not clickable
                    }

                    // Arrow pointing to the next evolution
                    if pokemon != evolutionChain.last {
                        Image(systemName: "arrow.down")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}

struct EvolutionCard: View {
    let pokemon: PokemonEvolution

    var body: some View {
        HStack(spacing: 16) {
            // Pokémon image
            AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 80, height: 80)

            // Pokémon name and ID
            VStack(alignment: .leading, spacing: 4) {
                Text(pokemon.name.capitalized)
                    .font(.custom("Poppins-SemiBold", size: 16))
                    .foregroundColor(Color("TextColor"))

                Text(String(format: "#%03d", pokemon.id))
                    .font(.custom("Poppins-Regular", size: 14))
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("CardColor")) // Use CardColor for background
                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4) // Subtle shadow for depth
        )
    }
}
