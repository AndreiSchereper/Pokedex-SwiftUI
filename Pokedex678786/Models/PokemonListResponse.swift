import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?   
    let results: [Pokemon]
}

struct Pokemon: Codable, Identifiable, Equatable {
    let name: String
    let url: String

    // Extract ID from the URL
    var id: Int {
        guard let id = url.split(separator: "/").last else { return 0 }
        return Int(id) ?? 0
    }

    // Generate the image URL for this Pokémon
    var imageUrl: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}

