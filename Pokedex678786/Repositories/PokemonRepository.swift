import Foundation

class PokemonRepository {
    private let apiService = PokemonAPIService.shared
    
    private var cachedPokemon: [Pokemon] = [] // Cache for fetched Pokémon
    private var nextPageUrl: String? = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
    
    // Fetch Pokémon from the API (with pagination)
    func fetchPokemonList(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        guard let nextPageUrl = nextPageUrl else {
            completion(.success([])) // No more pages
            return
        }

        apiService.fetchPokemonList(url: nextPageUrl) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.cachedPokemon.append(contentsOf: response.results)
                    self?.nextPageUrl = response.next // Update next page URL
                    completion(.success(self?.cachedPokemon ?? []))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    // Reset repository (useful when refreshing data)
    func reset() {
        cachedPokemon = []
        nextPageUrl = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=0"
    }
    
    func fetchPokemonDetails(by id: Int, completion: @escaping (Result<PokemonDetails, Error>) -> Void) {
            apiService.fetchPokemonDetails(by: id, completion: completion)
        }
    
    func fetchPokemonEvolutionChain(for id: Int, completion: @escaping (Result<PokemonEvolutionChain, Error>) -> Void) {
        apiService.fetchPokemonSpecies(for: id) { result in
            switch result {
            case .success(let species):
                // Fetch evolution chain using the URL from species data
                self.apiService.fetchEvolutionChain(from: species.evolutionChain.url, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }}
