import SwiftUI
struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    @State private var selectedPokemonID: Int?

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            VStack {
                // Search Bar
                SearchBar(text: $viewModel.searchQuery)
                    .onChange(of: viewModel.searchQuery) { _ in
                        viewModel.searchPokemon() // Trigger search on text change
                    }

                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.pokemonList) { pokemon in
                            PokemonCardView(pokemon: pokemon)
                                .onTapGesture {
                                    selectedPokemonID = pokemon.id
                                }
                        }

                        // Pagination Loader (only when not searching)
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        } else if !viewModel.isSearching { // Disable pagination during search
                            Color.clear
                                .onAppear {
                                    viewModel.fetchPokemonList()
                                }
                        } else if viewModel.pokemonList.isEmpty {
                            Text("No Pokémon Found")
                                .font(.custom("Poppins-SemiBold", size: 16))
                                .foregroundColor(.gray)
                                .padding()
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
            }
            .navigationTitle("Pokédex")
            .background(
                NavigationLink(
                    destination: DetailView(pokemonID: selectedPokemonID ?? 0),
                    tag: selectedPokemonID ?? 0,
                    selection: $selectedPokemonID
                ) {
                    EmptyView()
                }
                .hidden()
            )
            .onAppear {
                viewModel.fetchPokemonList()
                viewModel.fetchAllPokemon() // Pre-fetch all Pokémon for search
            }
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
        }
    }
}
