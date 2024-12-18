import Foundation

/// Handles API interactions for fetching Pokémon-related data.
class PokemonAPIService {
    static let shared = PokemonAPIService() // Singleton instance to reuse the service.

    private init() {} // Prevent direct initialization to enforce singleton usage.

    /// Generic method for fetching and decoding data from a URL.
    /// - Parameters:
    ///   - url: The endpoint to fetch data from.
    ///   - type: The type to decode the data into.
    ///   - completion: Completion handler with the decoded object or an error.
    private func fetchData<T: Decodable>(url: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let requestUrl = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            if let error = error {
                completion(.failure(error)) // Handle networking error.
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil))) // Handle missing data.
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(type, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error)) // Handle decoding errors.
            }
        }.resume()
    }

    /// Fetches a list of Pokémon from the given API URL.
    func fetchPokemonList(url: String, completion: @escaping (Result<PokemonListResponse, Error>) -> Void) {
        fetchData(url: url, type: PokemonListResponse.self, completion: completion)
    }

    /// Fetches details for a specific Pokémon by its ID.
    func fetchPokemonDetails(by id: Int, completion: @escaping (Result<PokemonDetails, Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
        fetchData(url: urlString, type: PokemonDetails.self, completion: completion)
    }

    /// Fetches species information for a Pokémon by its ID.
    func fetchPokemonSpecies(for id: Int, completion: @escaping (Result<PokemonSpecies, Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon-species/\(id)"
        fetchData(url: urlString, type: PokemonSpecies.self, completion: completion)
    }

    /// Fetches evolution chain by URL.
    func fetchEvolutionChain(from url: String, completion: @escaping (Result<PokemonEvolutionChain, Error>) -> Void) {
        fetchData(url: url, type: PokemonEvolutionChain.self, completion: completion)
    }
}
