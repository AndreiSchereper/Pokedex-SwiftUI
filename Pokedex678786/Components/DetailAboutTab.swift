import SwiftUI

/// View for displaying Pokémon's general information in the "About" tab.
struct DetailAboutTab: View {
    let details: PokemonDetails // Pokémon details to populate the tab

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Information Rows
            aboutRow(title: "Name", value: details.name.capitalized) // Display Pokémon name
            aboutRow(title: "ID", value: String(format: "#%03d", details.id)) // Display Pokémon ID
            aboutRow(title: "Base", value: "\(details.baseExperience) XP") // Display base experience
            aboutRow(title: "Weight", value: "\(Double(details.weight) / 10) kg") // Display weight in kilograms
            aboutRow(title: "Height", value: "\(Double(details.height) / 10) m") // Display height in meters
            aboutRow(
                title: "Types",
                value: details.types.map { $0.type.name.capitalized }.joined(separator: ", ") // Display types
            )
            aboutRow(
                title: "Abilities",
                value: details.abilities.map { $0.ability.name.capitalized }.joined(separator: ", ") // Display abilities
            )
        }
        .padding(.horizontal) // Add horizontal padding for better layout
    }

    /// Helper function to create a labeled row for Pokémon details.
    private func aboutRow(title: String, value: String) -> some View {
        HStack {
            // Row Title
            Text("\(title):")
                .font(.custom("Poppins-SemiBold", size: 14)) // Bold font for labels
                .foregroundColor(.gray) // Subdued gray color for labels

            Spacer() // Pushes the value to the right

            // Row Value
            Text(value)
                .font(.custom("Poppins-Regular", size: 14)) // Regular font for values
                .foregroundColor(Color("TextColor")) // Text color from app assets
                .multilineTextAlignment(.leading) // Aligns text to the left
        }
    }
}
