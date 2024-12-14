import SwiftUI

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = [] // Displayed Pokémon
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchQuery: String = "" // Search term
    @Published var isRefreshing = false
    @Published var isSearching = false // New flag to track search state

    private let repository = PokemonRepository()
    private var allPokemon: [Pokemon] = [] // Cached full Pokémon list

    func fetchPokemonList() {
        guard !isLoading, !isSearching else { return } // Prevent duplicate calls and block during search
        isLoading = true
        errorMessage = nil

        repository.fetchPokemonList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let newPokemon):
                    self?.pokemonList.append(contentsOf: newPokemon) // Append only the new Pokémon
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func fetchAllPokemon() {
        isLoading = true
        repository.fetchAllPokemon { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let allPokemon):
                    self?.allPokemon = allPokemon // Cache full list
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func searchPokemon() {
        isSearching = !searchQuery.isEmpty // Update the search state
        if searchQuery.isEmpty {
            // Reset to the initial displayed Pokémon (e.g., first 20)
            pokemonList = allPokemon.prefix(20).map { $0 }
        } else {
            pokemonList = allPokemon.filter {
                $0.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
}
