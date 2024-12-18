import SwiftUI

/// ViewModel for managing Pokémon list data, including search, pagination, and error handling.
class PokemonListViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var pokemonList: [Pokemon] = [] // List of Pokémon to display
    @Published var isLoading = false // Indicates whether data is being fetched
    @Published var errorMessage: String? // Stores error messages for display
    @Published var searchQuery: String = "" // Current search input by the user
    @Published var isSearching = false // Flag to indicate if a search is in progress

    // MARK: - Private Properties
    private var allPokemon: [Pokemon] = [] // Cache of all Pokémon for search functionality
    private var paginationOffset: Int = 0 // Tracks current offset for paginated fetches
    private let pageSize: Int = 20 // Number of Pokémon to fetch per page
    private let repository = PokemonRepository() // Repository for data fetching

    // MARK: - Public Methods

    /// Fetches a paginated list of Pokémon. Prevents fetching during loading or search.
    func fetchPokemonList() {
        guard !isLoading, !isSearching else { return } // Avoid duplicate calls
        isLoading = true // Indicate loading state

        repository.fetchPokemonList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false // Reset loading state
                switch result {
                case .success(let newPokemon):
                    self?.pokemonList.append(contentsOf: newPokemon) // Append new Pokémon
                    self?.paginationOffset += self?.pageSize ?? 0 // Update offset
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription // Handle errors
                }
            }
        }
    }

    /// Fetches the full list of Pokémon for search functionality. Ensures it runs only once.
    func fetchAllPokemon() {
        guard allPokemon.isEmpty else { return } // Avoid redundant calls
        isLoading = true

        repository.fetchAllPokemon { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let allPokemon):
                    self?.allPokemon = allPokemon // Cache all Pokémon
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription // Handle errors
                }
            }
        }
    }

    /// Filters Pokémon based on the search query or resets the list when the query is cleared.
    func searchPokemon() {
        isSearching = !searchQuery.isEmpty // Update search state
        if searchQuery.isEmpty {
            // Reset to the current paginated list if search is cleared
            pokemonList = Array(allPokemon.prefix(paginationOffset))
        } else {
            // Filter Pokémon based on search query (case-insensitive)
            pokemonList = allPokemon.filter {
                $0.name.localizedCaseInsensitiveContains(searchQuery)
            }
        }
    }
}
