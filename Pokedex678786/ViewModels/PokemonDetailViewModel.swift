import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemonDetails: PokemonDetails?
    @Published var evolutionChain: [PokemonEvolution]?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository = PokemonRepository()

    func fetchDetails(for id: Int) {
        isLoading = true
        errorMessage = nil

        repository.fetchPokemonDetails(by: id) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let details):
                    self?.pokemonDetails = details
                    self?.fetchEvolutionChain(for: id) // Fetch evolution chain after details
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func fetchEvolutionChain(for id: Int) {
        repository.fetchPokemonEvolutionChain(for: id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let chain):
                    self?.evolutionChain = chain.evolutionChainList
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
