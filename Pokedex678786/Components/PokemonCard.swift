import SwiftUI

/// A card component that displays a Pokémon's image, name, and ID.
struct PokemonCardView: View {
    let pokemon: Pokemon // Data model containing details about the Pokémon
    @State private var refreshID = UUID() // Unique ID to force a refresh

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

            // ID badge in the top-left corner
            Text(String(format: "%03d", pokemon.id)) // Format ID as a 3-digit number
                .font(.custom("Poppins-Medium", size: 12)) // Custom font for the ID
                .foregroundColor(.white) // White text color
                .padding(.horizontal, 8) // Horizontal padding inside the badge
                .padding(.vertical, 4) // Vertical padding inside the badge
                .background(Color.purple) // Purple background for the badge
                .cornerRadius(8) // Rounded corners for the badge
                .padding([.top, .leading], 12) // Positioning within the card
        }
        .frame(height: 200) // Fixed height for the card
        .onAppear {
            // Trigger a refresh when the view appears
            refreshID = UUID()
        }
    }
}
