import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Card Background
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white) // Solid white background for the card
                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)

            VStack(spacing: 12) {
                // Pokémon image
                AsyncImage(url: pokemon.imageUrl) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120) // Adjusted image size
                } placeholder: {
                    ProgressView()
                }

                // Pokémon name (centered below the image)
                Text(pokemon.name.capitalized)
                    .font(.custom("Poppins-SemiBold", size: 16))
                    .foregroundColor(Color("TextColor"))
                    .multilineTextAlignment(.center) // Center text
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Center content
            .padding(.horizontal, 12)

            // ID Badge
            Text(String(format: "%03d", pokemon.id)) // 3-digit ID formatting
                .font(.custom("Poppins-Medium", size: 12)) // Updated to Medium font
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.purple)
                .cornerRadius(8)
                .padding([.top, .leading], 12) // Position in the top-left corner
        }
        .frame(height: 200) // Set fixed card height
    }
}
