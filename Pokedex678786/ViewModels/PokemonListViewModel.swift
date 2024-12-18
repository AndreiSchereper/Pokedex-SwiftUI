import SwiftUI

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchQuery: String = ""
    @Published var isSearching = false

    var lastVisiblePokemonID: Int? // Tracks the last visible Pokémon's ID
    private var allPokemon: [Pokemon] = []
    private var paginationOffset: Int = 0
    private let pageSize: Int = 20
    private let repository = PokemonRepository()

    func fetchPokemonList() {
        guard !isLoading, !isSearching else { return }
        isLoading = true
        repository.fetchPokemonList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let newPokemon):
                    self?.pokemonList.append(contentsOf: newPokemon)
                    self?.paginationOffset += self?.pageSize ?? 0
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func fetchAllPokemon() {
        guard allPokemon.isEmpty else { return }
        isLoading = true
        repository.fetchAllPokemon { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let allPokemon):
                    self?.allPokemon = allPokemon
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func searchPokemon() {
        isSearching = !searchQuery.isEmpty
        if searchQuery.isEmpty {
            pokemonList = Array(allPokemon.prefix(paginationOffset))
        } else {
            pokemonList = allPokemon.filter {
                $0.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
}
