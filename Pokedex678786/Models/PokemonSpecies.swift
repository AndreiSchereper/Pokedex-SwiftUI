import Foundation

/// Represents a Pokémon species, including its evolution chain details.
struct PokemonSpecies: Codable {
    let evolutionChain: EvolutionChain // Information about the evolution chain

    // Maps JSON key "evolution_chain" to the property `evolutionChain`
    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
    }

    /// Represents the evolution chain URL.
    struct EvolutionChain: Codable {
        let url: String // URL for fetching the evolution chain data
    }
}
