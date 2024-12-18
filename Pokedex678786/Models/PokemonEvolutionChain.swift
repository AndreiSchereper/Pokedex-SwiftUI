import Foundation

/// Represents the evolution chain of a Pokémon.
struct PokemonEvolutionChain: Codable {
    let chain: ChainLink // The starting point of the evolution chain

    /// Converts the evolution chain into a list of `PokemonEvolution` objects.
    var evolutionChainList: [PokemonEvolution] {
        var result: [PokemonEvolution] = []
        var current = chain

        // Traverse the chain and build the list
        while let species = current.species {
            result.append(PokemonEvolution(
                name: species.name,
                id: species.id,
                imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(species.id).png"
            ))

            // Exit the loop if there are no further evolutions
            if current.evolvesTo.isEmpty { break }
            current = current.evolvesTo[0]
        }

        return result
    }

    /// Represents a link in the evolution chain.
    struct ChainLink: Codable {
        let species: Species?        // Details about the Pokémon species
        let evolvesTo: [ChainLink]   // Array of possible evolutions

        enum CodingKeys: String, CodingKey {
            case species
            case evolvesTo = "evolves_to" // Maps "evolves_to" in JSON
        }
    }

    /// Represents a Pokémon species in the evolution chain.
    struct Species: Codable {
        let name: String   // Name of the Pokémon species
        let url: String    // URL containing detailed information

        /// Extracts the Pokémon's ID from its URL.
        var id: Int {
            Int(url.split(separator: "/").last ?? "") ?? 0
        }
    }
}

/// Represents a Pokémon in the evolution chain.
struct PokemonEvolution: Identifiable, Equatable {
    let name: String   // Pokémon name
    let id: Int        // Pokémon ID
    let imageUrl: String // URL for the Pokémon's sprite image

    /// Implements Equatable to compare Pokémon by ID.
    static func == (lhs: PokemonEvolution, rhs: PokemonEvolution) -> Bool {
        return lhs.id == rhs.id
    }
}
