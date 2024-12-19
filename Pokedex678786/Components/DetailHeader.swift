import SwiftUI
import SwiftData

/// A header view that displays a Pokémon's name, ID, types, and sprites.
struct DetailHeader: View {
    let details: PokemonDetails // The Pokémon details to display
    @Environment(\.modelContext) private var context // Access the Swift Data context
    @State private var isFavorite: Bool = false // Tracks if the Pokémon is a favorite
    @State private var isShareSheetPresented: Bool = false // Tracks if the share sheet is presented

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

                    Spacer()

                    // Share Button
                    Button(action: sharePokemon) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundColor(.blue)
                            .font(.title)
                    }
                    .sheet(isPresented: $isShareSheetPresented) {
                        ShareSheet(activityItems: [generateShareContent()])
                    }

                    // Heart Button
                    Button(action: toggleFavorite) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                    .onAppear {
                        // Initialize the favorite status
                        isFavorite = isPokemonFavorite(details.id)
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

    // MARK: - Share Logic

    /// Opens the share sheet for the Pokémon.
    private func sharePokemon() {
        isShareSheetPresented = true
    }

    /// Generates the shareable content with all Pokémon details.
    private func generateShareContent() -> String {
        var shareText = "Check out this Pokémon:\n\n"
        shareText += "Name: \(details.name.capitalized)\n"
        shareText += "ID: #\(String(format: "%03d", details.id))\n"
        shareText += "Types: \(details.types.map { $0.type.name.capitalized }.joined(separator: ", "))\n"
        shareText += "Height: \(details.height) decimeters\n"
        shareText += "Weight: \(details.weight) hectograms\n"
        shareText += "Base Experience: \(details.baseExperience)\n\n"
        if let frontUrl = details.sprites.frontDefault {
            shareText += "Front Sprite: \(frontUrl)\n"
        }
        if let backUrl = details.sprites.backDefault {
            shareText += "Back Sprite: \(backUrl)\n"
        }
        return shareText
    }

    // MARK: - Favorite Logic

    /// Toggles the favorite state of the Pokémon.
    private func toggleFavorite() {
        if isFavorite {
            removeFavorite(details.id)
        } else {
            addFavorite(details)
        }
        isFavorite.toggle()
    }

    /// Adds the Pokémon to the favorites.
    private func addFavorite(_ pokemon: PokemonDetails) {
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

/// A simple wrapper for presenting a share sheet.
struct ShareSheet: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}
