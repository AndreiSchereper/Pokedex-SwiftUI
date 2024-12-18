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
                        viewModel.searchPokemon()
                    }

                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                }

                ScrollViewReader { scrollProxy in
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(viewModel.pokemonList) { pokemon in
                                PokemonCardView(pokemon: pokemon)
                                    .onTapGesture {
                                        selectedPokemonID = pokemon.id
                                    }
                            }

                            // Pagination Loader
                            if viewModel.isLoading {
                                ProgressView()
                                    .padding()
                            } else if !viewModel.isSearching {
                                Color.clear
                                    .frame(height: 50)
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
                        .onChange(of: viewModel.pokemonList) { _ in
                            if viewModel.isSearching {
                                // Scroll to the top only during a search
                                if let firstPokemon = viewModel.pokemonList.first {
                                    scrollProxy.scrollTo(firstPokemon.id, anchor: .top)
                                }
                            }
                        }
                    }
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
                viewModel.fetchAllPokemon()
            }
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
        }
    }
}
