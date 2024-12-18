/// Represents detailed information about a Pokémon.
struct PokemonDetails: Codable {
    let id: Int                // Pokémon ID
    let name: String           // Pokémon name
    let baseExperience: Int    // Base experience points
    let height: Int            // Height of the Pokémon (in decimeters)
    let weight: Int            // Weight of the Pokémon (in hectograms)
    let sprites: Sprites       // URLs for front and back images of the Pokémon
    let types: [PokemonType]   // Array of types associated with the Pokémon
    let abilities: [Ability]   // Array of abilities the Pokémon can have
    let stats: [Stat]          // Array of stats for the Pokémon

    // Maps JSON keys to properties with different names
    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, sprites, types, abilities, stats
        case baseExperience = "base_experience"
    }

    /// Contains image URLs for the Pokémon.
    struct Sprites: Codable {
        let frontDefault: String? // URL for the front-facing image
        let backDefault: String?  // URL for the back-facing image

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case backDefault = "back_default"
        }
    }

    /// Represents a type associated with the Pokémon.
    struct PokemonType: Codable {
        let type: TypeName       // Contains the name of the type

        struct TypeName: Codable {
            let name: String    // Name of the type (e.g., "fire", "water")
        }
    }

    /// Represents an ability of the Pokémon.
    struct Ability: Codable {
        let ability: AbilityName // Contains the name of the ability

        struct AbilityName: Codable {
            let name: String    // Name of the ability (e.g., "Overgrow")
        }
    }

    /// Represents a stat of the Pokémon.
    struct Stat: Codable {
        let baseStat: Int       // Base value of the stat
        let stat: StatName      // Contains the name of the stat

        enum CodingKeys: String, CodingKey {
            case baseStat = "base_stat"
            case stat
        }

        struct StatName: Codable {
            let name: String    // Name of the stat (e.g., "speed", "attack")
        }
    }
}
