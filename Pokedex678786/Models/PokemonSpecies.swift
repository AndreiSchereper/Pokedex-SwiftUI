import Foundation

struct PokemonSpecies: Codable {
    let evolutionChain: EvolutionChain

    enum CodingKeys: String, CodingKey {
        case evolutionChain = "evolution_chain"
    }

    struct EvolutionChain: Codable {
        let url: String
    }
}

