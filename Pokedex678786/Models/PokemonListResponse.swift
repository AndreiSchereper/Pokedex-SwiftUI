import Foundation

/// Response model for the Pokémon list API.
struct PokemonListResponse: Codable {
    let count: Int           // Total number of Pokémon available
    let next: String?        // URL for the next page of results
    let previous: String?    // URL for the previous page of results
    let results: [Pokemon]   // Array of Pokémon data
}

/// Model representing an individual Pokémon.
struct Pokemon: Codable, Identifiable, Equatable {
    let name: String        // Name of the Pokémon
    let url: String         // URL containing more details about the Pokémon

    /// Computed property to extract the Pokémon ID from its URL.
    var id: Int {
        guard let id = url.split(separator: "/").last else { return 0 }
        return Int(id) ?? 0
    }

    /// Computed property to generate the URL for the Pokémon's sprite image.
    var imageUrl: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}
