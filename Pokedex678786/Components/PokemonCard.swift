import SwiftUI
import SwiftData

/// A card component that displays a Pokémon's image, name, and ID.
struct PokemonCardView: View {
    let pokemon: Pokemon // Data model containing details about the Pokémon
    @State private var refreshID = UUID() // Unique ID to force a refresh
    @Environment(\.modelContext) private var context // Access the Swift Data context
    @State private var isFavorite: Bool = false // Tracks if the Pokémon is a favorite
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            // Background for the card
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("CardColor")) // Fetch color from Assets
                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4) // Subtle shadow for depth
            
            VStack(spacing: 12) {
                // Pokémon image
                AsyncImage(
                    url: pokemon.imageUrl,
                    transaction: Transaction(animation: .easeInOut)
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                    case .failure:
                        Image(systemName: "photo") // Fallback if the image fails to load
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                .id(refreshID) // Force AsyncImage to refresh
                
                // Pokémon name
                Text(pokemon.name.capitalized)
                    .font(.custom("Poppins-SemiBold", size: 16)) // Custom font for the name
                    .foregroundColor(Color("TextColor")) // Text color from Assets
                    .multilineTextAlignment(.center) // Center-align text
                    .lineLimit(1) // Limit to one line
                    .minimumScaleFactor(0.8) // Scale text to fit if necessary
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Center content within the card
            .padding(.horizontal, 12)
            HStack{
                // ID badge in the top-left corner
                Text(String(format: "%03d", pokemon.id)) // Format ID as a 3-digit number
                    .font(.custom("Poppins-Medium", size: 12)) // Custom font for the ID
                    .foregroundColor(.white) // White text color
                    .padding(.horizontal, 8) // Horizontal padding inside the badge
                    .padding(.vertical, 4) // Vertical padding inside the badge
                    .background(Color.purple) // Purple background for the badge
                    .cornerRadius(8) // Rounded corners for the badge
                    
                Spacer()
                // Heart Button
                Button(action: toggleFavorite) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(Color("AccentColor"))
                        .font(.title)
                        .frame(width: 24, height: 24)
                }
                .onAppear {
                    // Initialize the favorite status
                    isFavorite = isPokemonFavorite(pokemon.id)
                }
            }
            .padding(
                [.top, .leading, .trailing],
                8
            ) // Positioning within the card
            
        }
        .frame(height: 200) // Fixed height for the card
        .onAppear {
            // Trigger a refresh when the view appears
            refreshID = UUID()
        }
    }
    
    
    /// Toggles the favorite state of the Pokémon.
    private func toggleFavorite() {
        if isFavorite {
            removeFavorite(pokemon.id)
        } else {
            addFavorite(pokemon)
        }
        isFavorite.toggle()
    }
    
    /// Adds the Pokémon to the favorites.
    private func addFavorite(_ pokemon: Pokemon) {
        let favorite = FavoritePokemon(
            id: pokemon.id,
            name: pokemon.name
        )
        context.insert(favorite) // Insert the FavoritePokemon into the container
        try? context.save() // Save changes to persist the favorite
    }
    
    /// Removes the Pokémon from the favorites.
    private func removeFavorite(_ id: Int) {
        if let favorite = fetchFavorite(by: id) {
            context.delete(favorite) // Delete the favorite from the container
            try? context.save() // Save changes to persist the deletion
        }
    }
    
    /// Checks if the Pokémon is already a favorite.
    private func isPokemonFavorite(_ id: Int) -> Bool {
        return fetchFavorite(by: id) != nil
    }
    
    /// Fetches the favorite Pokémon from the container by ID.
    private func fetchFavorite(by id: Int) -> FavoritePokemon? {
        // Create a FetchDescriptor with a predicate to filter by ID
        let descriptor = FetchDescriptor<FavoritePokemon>(
            predicate: #Predicate { $0.id == id }
        )
        // Perform the fetch using the descriptor
        return try? context.fetch(descriptor).first
    }
}
