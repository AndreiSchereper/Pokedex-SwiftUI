import Foundation
import SwiftData

/// Represents a favorite Pokémon stored in the database.
@Model
class FavoritePokemon {
    @Attribute(.unique) var id: Int // Pokémon's unique ID
    var name: String                // Pokémon's name
    
    /// Creates a new favorite Pokémon.
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
