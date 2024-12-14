import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel = PokemonDetailViewModel()
    let pokemonID: Int

    @State private var selectedTab = "About" // Default tab

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading Pokémon...")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundColor(.red)
            } else if let details = viewModel.pokemonDetails {
                ScrollView {
                    VStack(spacing: 16) {
                        DetailHeader(details: details)

                        DetailTabs(selectedTab: $selectedTab)

                        if selectedTab == "About" {
                            DetailAboutTab(details: details)
                        } else if selectedTab == "Stats" {
                            DetailStatsTab(details: details)
                        } else if selectedTab == "Evolution" {
                            if let evolutionChain = viewModel.evolutionChain {
                                DetailEvolutionTab(evolutionChain: evolutionChain, currentPokemonID: pokemonID)
                            } else {
                                Text("Loading Evolution Chain...")
                            }
                        }
                    }
                }
                .padding(.horizontal)
            } else {
                Text("No Data Available")
            }
        }
        .background(Color("BackgroundColor").edgesIgnoringSafeArea(.all))
        .onAppear {
            viewModel.fetchDetails(for: pokemonID)
        }
        .navigationBarBackButtonHidden(false)
    }
}
#Preview {
    ContentView()
}
