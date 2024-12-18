import SwiftUI

/// Main view displaying a list of Pokémon with search, pagination, and navigation functionality.
struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel() // ViewModel for managing Pokémon data
    @State private var selectedPokemonID: Int? // Tracks the currently selected Pokémon ID for navigation

    // Define a two-column grid layout
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                SearchBar(text: $viewModel.searchQuery)
                    .onChange(of: viewModel.searchQuery) { _ in
                        viewModel.searchPokemon() // Trigger search when query changes
                    }

                // Error Handling
                if let errorMessage = viewModel.errorMessage {
                    errorStateView(errorMessage: errorMessage)
                }

                // Pokémon Grid with Pagination
                ScrollViewReader { scrollProxy in
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.pokemonList) { pokemon in
                                PokemonCardView(pokemon: pokemon)
                                    .onTapGesture {
                                        selectedPokemonID = pokemon.id // Set selected Pokémon for navigation
                                    }
                            }

                            // Pagination Loader
                            if viewModel.isLoading {
                                ProgressView()
                                    .padding()
                            } else if !viewModel.isSearching {
                                // Trigger pagination when the user scrolls to the bottom
                                Color.clear
                                    .frame(height: 50)
                                    .onAppear {
                                        viewModel.fetchPokemonList()
                                    }
                            }

                            // Message for No Search Results
                            if viewModel.isSearching && viewModel.pokemonList.isEmpty {
                                noResultsView
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                        .onChange(of: viewModel.pokemonList) { _ in
                            // Automatically scroll to the top when a search is performed
                            if viewModel.isSearching, let firstPokemon = viewModel.pokemonList.first {
                                scrollProxy.scrollTo(firstPokemon.id, anchor: .top)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Pokédex") // Screen title
            .background(
                NavigationLink(
                    destination: DetailView(pokemonID: selectedPokemonID ?? 0), // Navigate to DetailView
                    tag: selectedPokemonID ?? 0,
                    selection: $selectedPokemonID
                ) {
                    EmptyView()
                }
                .hidden() // Hide the NavigationLink UI
            )
            .onAppear {
                viewModel.fetchPokemonList() // Fetch initial list of Pokémon
                viewModel.fetchAllPokemon() // Pre-fetch all Pokémon for search
            }
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all)) // Custom background color
        }
    }

    /// Displays an error state view.
    /// - Parameter errorMessage: The error message to display.
    private func errorStateView(errorMessage: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.red) // Red error icon
            Text("Something went wrong.")
                .font(.custom("Poppins-SemiBold", size: 18))
                .foregroundColor(.red)
            Text(errorMessage)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
    }

    /// Displays a view for no search results.
    private var noResultsView: some View {
        Text("No Pokémon Found")
            .font(.custom("Poppins-SemiBold", size: 16))
            .foregroundColor(.gray)
            .padding()
    }
}
