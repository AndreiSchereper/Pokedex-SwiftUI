struct PokemonDetails: Codable {
    let id: Int
    let name: String
    let baseExperience: Int
    let height: Int
    let weight: Int
    let sprites: Sprites
    let types: [PokemonType]
    let abilities: [Ability]
    let stats: [Stat]

    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, sprites, types, abilities, stats
        case baseExperience = "base_experience" // Map base_experience to baseExperience
    }

    struct Sprites: Codable {
        let frontDefault: String?
        let backDefault: String?

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case backDefault = "back_default"
        }
    }

    struct PokemonType: Codable {
        let type: TypeName

        struct TypeName: Codable {
            let name: String
        }
    }

    struct Ability: Codable {
        let ability: AbilityName

        struct AbilityName: Codable {
            let name: String
        }
    }

    struct Stat: Codable {
        let baseStat: Int
        let stat: StatName

        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case stat
        }

        struct StatName: Codable {
            let name: String
        }
    }
}


