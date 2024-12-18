import SwiftUI

/// A header view that displays a Pokémon's name, ID, types, and sprites.
struct DetailHeader: View {
    let details: PokemonDetails // The Pokémon details to display

    var body: some View {
        VStack(spacing: 16) {
            // Display the Pokémon's name and ID
            HStack(alignment: .center) {
                // Pokémon Name
                Text(details.name.capitalized)
                    .font(.custom("Poppins-SemiBold", size: 32))
                    .foregroundColor(Color("TextColor"))

                Spacer() // Pushes the ID to the far right

                // Pokémon ID
                Text(String(format: "#%03d", details.id)) // Formats ID as a 3-digit string
                    .font(.custom("Poppins-Bold", size: 24))
                    .foregroundColor(.gray)
            }

            // Display the Pokémon's types, aligned to the left
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    ForEach(details.types, id: \.type.name) { type in
                        // Type Badge
                        Text(type.type.name.capitalized)
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(typeColor(for: type.type.name)) // Background color based on type
                            .cornerRadius(16) // Rounded badge
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Aligns types to the left

            // Display the Pokémon's front and (if available) back sprites
            HStack(spacing: 16) {
                // Front Sprite
                AsyncImage(url: URL(string: details.sprites.frontDefault ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView() // Loading indicator for front sprite
                }
                .frame(width: 150, height: 150) // Fixed size for the sprite

                // Back Sprite (only if available)
                if let backSpriteUrl = details.sprites.backDefault, !backSpriteUrl.isEmpty {
                    AsyncImage(url: URL(string: backSpriteUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(12)
                    } placeholder: {
                        ProgressView() // Loading indicator for back sprite
                    }
                    .frame(width: 150, height: 150) // Fixed size for the sprite
                }
            }
        }
    }
}
