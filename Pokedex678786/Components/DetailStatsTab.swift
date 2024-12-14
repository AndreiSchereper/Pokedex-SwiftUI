import SwiftUI

struct DetailStatsTab: View {
    let details: PokemonDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(details.stats, id: \.stat.name) { stat in
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(stat.stat.name.capitalized)
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("\(stat.baseStat)")
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(.gray)
                    }
                    ProgressBar(progress: min(Double(stat.baseStat) / 100.0, 1.0), color: Color("AccentColor"))
                        .frame(height: 8)
                }
            }
        }
    }
}
