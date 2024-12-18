import Foundation

/// ViewModel responsible for managing Pokémon details and evolution chain data.
class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetails: PokemonDetails? // Stores the details of the selected Pokémon.
    @Published var evolutionChain: [PokemonEvolution]? // Stores the evolution chain of the Pokémon.
    @Published var isLoading = false // Indicates whether data is being loaded.
    @Published var errorMessage: String? // Stores any error message encountered during data fetching.

    private let repository = PokemonRepository() // Repository for handling data operations.

    /// Fetches details of a Pokémon by its ID.
    /// - Parameter id: The ID of the Pokémon whose details are to be fetched.
    func fetchDetails(for id: Int) {
        isLoading = true // Start loading.
        errorMessage = nil // Reset error message.

        // Fetch Pokémon details from the repository.
        repository.fetchPokemonDetails(by: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false // Stop loading.
                switch result {
                case .success(let details):
                    self?.pokemonDetails = details // Update the Pokémon details.
                    self?.fetchEvolutionChain(for: id) // Fetch evolution chain after details are fetched.
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription // Handle error.
                }
            }
        }
    }

    /// Fetches the evolution chain of a Pokémon by its ID.
    /// - Parameter id: The ID of the Pokémon whose evolution chain is to be fetched.
    private func fetchEvolutionChain(for id: Int) {
        // Fetch evolution chain from the repository.
        repository.fetchPokemonEvolutionChain(for: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let chain):
                    self?.evolutionChain = chain.evolutionChainList // Update the evolution chain.
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription // Handle error.
                }
            }
        }
    }
}
