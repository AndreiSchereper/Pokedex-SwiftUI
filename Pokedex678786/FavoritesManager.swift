import Foundation

/// Manages favorite Pokémon IDs using UserDefaults.
class FavoritesManager {
    private let favoritesKey = "favoritedPokemonIDs" // Key for UserDefaults

    static let shared = FavoritesManager() // Singleton instance

    private init() {} // Prevent external instantiation

    /// Retrieves the set of favorited Pokémon IDs.
    func getFavorites() -> Set<Int> {
        let ids = UserDefaults.standard.array(forKey: favoritesKey) as? [Int] ?? []
        return Set(ids)
    }

    /// Adds a Pokémon ID to the favorites.
    func addFavorite(_ id: Int) {
        var favorites = getFavorites()
        favorites.insert(id)
        saveFavorites(favorites)
    }

    /// Removes a Pokémon ID from the favorites.
    func removeFavorite(_ id: Int) {
        var favorites = getFavorites()
        favorites.remove(id)
        saveFavorites(favorites)
    }

    /// Checks if a Pokémon ID is favorited.
    func isFavorite(_ id: Int) -> Bool {
        return getFavorites().contains(id)
    }

    /// Saves the updated favorites set to UserDefaults.
    private func saveFavorites(_ favorites: Set<Int>) {
        UserDefaults.standard.set(Array(favorites), forKey: favoritesKey)
    }
}

