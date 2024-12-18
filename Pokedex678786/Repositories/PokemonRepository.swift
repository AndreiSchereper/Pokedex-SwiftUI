import Foundation

/// Repository for handling Pokémon data fetching and caching.
class PokemonRepository {
    private let apiService = PokemonAPIService.shared // Singleton instance of API service.
    private var cachedPokemon: [Pokemon] = [] // Cache for fetched Pokémon.
    private var nextPageUrl: String? = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0" // URL for pagination.

    /// Fetches a paginated list of Pokémon.
    /// - Parameter completion: Completion handler with a result containing either new Pokémon or an error.
    func fetchPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        guard let nextPageUrl = nextPageUrl else {
            completion(.success([])) // No more pages to fetch.
            return
        }

        apiService.fetchPokemonList(url: nextPageUrl) { [weak self] result in
            guard let self = self else { return } // Safeguard against memory leaks.
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    let newPokemon = response.results
                    self.cachedPokemon.append(contentsOf: newPokemon) // Add new Pokémon to the cache.
                    self.nextPageUrl = response.next // Update pagination URL.
                    completion(.success(newPokemon)) // Return only the newly fetched Pokémon.
                case .failure(let error):
                    completion(.failure(error)) // Propagate error to the caller.
                }
            }
        }
    }

    /// Fetches the entire list of Pokémon for search purposes.
    /// - Parameter completion: Completion handler with a result containing all Pokémon or an error.
    func fetchAllPokemon(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let fullListUrl = "https://pokeapi.co/api/v2/pokemon?limit=1025&offset=0" // URL to fetch all Pokémon.

        apiService.fetchPokemonList(url: fullListUrl) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.cachedPokemon = response.results // Cache the full Pokémon list.
                    completion(.success(response.results)) // Return the full list of Pokémon.
                case .failure(let error):
                    completion(.failure(error)) // Propagate error to the caller.
                }
            }
        }
    }

    /// Resets the repository's cache and pagination state.
    func reset() {
        cachedPokemon = [] // Clear the Pokémon cache.
        nextPageUrl = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0" // Reset to the first page.
    }

    /// Fetches detailed information about a specific Pokémon by ID.
    /// - Parameters:
    ///   - id: The ID of the Pokémon.
    ///   - completion: Completion handler with a result containing Pokémon details or an error.
    func fetchPokemonDetails(by id: Int, completion: @escaping (Result<PokemonDetails, Error>) -> Void) {
        apiService.fetchPokemonDetails(by: id, completion: completion)
    }

    /// Fetches the evolution chain of a Pokémon by its ID.
    /// - Parameters:
    ///   - id: The ID of the Pokémon whose evolution chain is to be fetched.
    ///   - completion: Completion handler with a result containing the evolution chain or an error.
    func fetchPokemonEvolutionChain(for id: Int, completion: @escaping (Result<PokemonEvolutionChain, Error>) -> Void) {
        apiService.fetchPokemonSpecies(for: id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let species):
                self.apiService.fetchEvolutionChain(from: species.evolutionChain.url, completion: completion)
            case .failure(let error):
                completion(.failure(error)) // Propagate error to the caller.
            }
        }
    }
}
