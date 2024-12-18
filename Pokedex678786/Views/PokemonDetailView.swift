import SwiftUI

/// Displays detailed information about a Pokémon, including its stats, evolution chain, and additional data.
struct DetailView: View {
    @StateObject private var viewModel = PokemonDetailViewModel() // ViewModel to manage data fetching and state
    let pokemonID: Int // The ID of the Pokémon to be displayed

    @State private var selectedTab = "About" // Tracks the currently selected tab (default: "About")

    var body: some View {
        ZStack {
            // Background color for the entire view
            Color("BackgroundColor")
                .edgesIgnoringSafeArea(.all)

            // Main content handling different states
            if viewModel.isLoading {
                loadingStateView
            } else if let errorMessage = viewModel.errorMessage {
                errorStateView(errorMessage: errorMessage)
            } else if let details = viewModel.pokemonDetails {
                contentView(details: details)
            } else {
                noDataStateView
            }
        }
        .onAppear {
            viewModel.fetchDetails(for: pokemonID) // Trigger data fetch when the view appears
        }
        .navigationBarBackButtonHidden(false) // Ensure the back button is shown in the navigation bar
    }

    /// View displayed while data is loading
    private var loadingStateView: some View {
        VStack {
            ProgressView("Loading Pokémon...")
                .progressViewStyle(CircularProgressViewStyle(tint: Color("AccentColor")))
                .scaleEffect(1.5) // Larger progress indicator for better visibility
            Spacer().frame(height: 20)
            Text("Please wait while we fetch details.")
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.gray)
        }
    }

    /// View displayed when an error occurs
    /// - Parameter errorMessage: The error message to display
    private func errorStateView(errorMessage: String) -> some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 50))
                .foregroundColor(.red) // Red warning icon
            Text("Oops! Something went wrong.")
                .font(.custom("Poppins-SemiBold", size: 18))
                .foregroundColor(.red)
            Text(errorMessage)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            Button(action: {
                viewModel.fetchDetails(for: pokemonID) // Retry fetching data
            }) {
                Text("Retry")
                    .font(.custom("Poppins-SemiBold", size: 16))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(8) // Rounded button for retry
            }
        }
    }

    /// Main content view displaying Pokémon details
    /// - Parameter details: The Pokémon details to display
    private func contentView(details: PokemonDetails) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                // Header section with Pokémon name, ID, and sprites
                DetailHeader(details: details)

                // Tabs for "About", "Stats", and "Evolution"
                if let firstType = details.types.first {
                    DetailTabs(
                        selectedTab: $selectedTab,
                        typeColor: typeColor(for: firstType.type.name) // Tab background color based on type
                    )
                }

                // Tab-specific content
                Group {
                    if selectedTab == "About" {
                        DetailAboutTab(details: details)
                    } else if selectedTab == "Stats" {
                        DetailStatsTab(details: details)
                    } else if selectedTab == "Evolution" {
                        if let evolutionChain = viewModel.evolutionChain {
                            DetailEvolutionTab(evolutionChain: evolutionChain, currentPokemonID: pokemonID)
                        } else {
                            VStack(spacing: 16) {
                                ProgressView("Loading Evolution Chain...")
                                    .progressViewStyle(CircularProgressViewStyle(tint: Color("AccentColor")))
                                Text("Fetching Evolution Data...")
                                    .font(.custom("Poppins-Regular", size: 14))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
    }

    /// View displayed when no data is available
    private var noDataStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "questionmark.circle.fill")
                .font(.system(size: 50))
                .foregroundColor(.gray) // Neutral icon for no data
            Text("No Data Available")
                .font(.custom("Poppins-SemiBold", size: 18))
                .foregroundColor(.gray)
        }
    }
}
