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

                        // Pagination Loader
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        } else {
                            Color.clear
                                .onAppear {
                                    viewModel.fetchPokemonList()
                                }
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
            }
            .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all)) // Use custom background color
        }
    }
}
