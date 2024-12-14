import Foundation

struct PokemonEvolutionChain: Codable {
    let chain: ChainLink

    var evolutionChainList: [PokemonEvolution] {
        var result: [PokemonEvolution] = []
        var current = chain

        while let species = current.species {
            result.append(PokemonEvolution(
                name: species.name,
                id: species.id,
                imageUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(species.id).png"
            ))

            if current.evolvesTo.isEmpty { break }
            current = current.evolvesTo[0]
        }

        return result
    }

    struct ChainLink: Codable {
        let species: Species?
        let evolvesTo: [ChainLink]

        enum CodingKeys: String, CodingKey {
            case species
            case evolvesTo = "evolves_to"
        }
    }

    struct Species: Codable {
        let name: String
        let url: String

        var id: Int {
            Int(url.split(separator: "/").last ?? "") ?? 0
        }
    }
}

struct PokemonEvolution: Identifiable, Equatable {
    let name: String
    let id: Int
    let imageUrl: String

    // Explicitly implement Equatable
    static func == (lhs: PokemonEvolution, rhs: PokemonEvolution) -> Bool {
        return lhs.id == rhs.id
    }
}
