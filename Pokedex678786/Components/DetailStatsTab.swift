import SwiftUI

/// Displays the stats of a Pokémon with a progress bar for each stat.
struct DetailStatsTab: View {
    let details: PokemonDetails // Details of the Pokémon, including stats and type information

    var body: some View {
        VStack(alignment: .leading, spacing: 16) { // Layout for the stats list
            ForEach(details.stats, id: \.stat.name) { stat in
                VStack(alignment: .leading, spacing: 4) { // Layout for each stat row
                    HStack {
                        // Stat Name
                        Text(stat.stat.name.capitalized) // Capitalized stat name
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(.gray) // Gray for text label
                        
                        Spacer() // Spacer pushes the value to the right
                        
                        // Stat Value
                        Text("\(stat.baseStat)") // Display the stat value
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(.gray) // Gray for text value
                    }

                    // Progress Bar representing the stat value
                    ProgressBar(
                        progress: min(Double(stat.baseStat) / 255.0, 1.0), // Limit progress to 1.0 (100%)
                        color: typeColor(for: details.types.first?.type.name ?? "unknown") // Dynamic bar color based on type
                    )
                    .frame(height: 8) // Fixed height for progress bar
                }
            }
        }
    }
}

