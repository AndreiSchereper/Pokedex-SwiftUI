import SwiftUI

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isRefreshing = false

    private let repository = PokemonRepository()

    func fetchPokemonList() {
        guard !isLoading else { return } // Prevent duplicate calls
        isLoading = true
        errorMessage = nil

        repository.fetchPokemonList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let newPokemon):
                    self?.pokemonList = newPokemon
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func refreshPokemonList() {
        isRefreshing = true
        repository.reset()
        repository.fetchPokemonList { [weak self] result in
            DispatchQueue.main.async {
                self?.isRefreshing = false
                switch result {
                case .success(let newPokemon):
                    self?.pokemonList = newPokemon
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
