import Foundation

class PokemonAPIService {
    static let shared = PokemonAPIService() // Singleton instance
    
    private init() {} // Prevent direct initialization

    func fetchPokemonList(url: String, completion: @escaping (Result<PokemonListResponse, Error>) -> Void) {
        guard let requestUrl = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: requestUrl) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPokemonDetails(by id: Int, completion: @escaping (Result<PokemonDetails, Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let pokemonDetails = try JSONDecoder().decode(PokemonDetails.self, from: data)
                completion(.success(pokemonDetails))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPokemonSpecies(for id: Int, completion: @escaping (Result<PokemonSpecies, Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon-species/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }

            do {
                let species = try JSONDecoder().decode(PokemonSpecies.self, from: data)
                completion(.success(species))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    // Fetch evolution chain by URL
    func fetchEvolutionChain(from url: String, completion: @escaping (Result<PokemonEvolutionChain, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }

            do {
                let evolutionChain = try JSONDecoder().decode(PokemonEvolutionChain.self, from: data)
                completion(.success(evolutionChain))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
