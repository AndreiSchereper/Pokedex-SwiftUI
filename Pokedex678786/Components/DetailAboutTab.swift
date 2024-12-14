import SwiftUI

struct DetailAboutTab: View {
    let details: PokemonDetails

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            aboutRow(title: "Name", value: details.name.capitalized)
            aboutRow(title: "ID", value: String(format: "#%03d", details.id))
            aboutRow(title: "Base", value: "\(details.baseExperience) XP")
            aboutRow(title: "Weight", value: "\(Double(details.weight) / 10) kg")
            aboutRow(title: "Height", value: "\(Double(details.height) / 10) m")
            aboutRow(title: "Types", value: details.types.map { $0.type.name.capitalized }.joined(separator: ", "))
            aboutRow(title: "Abilities", value: details.abilities.map { $0.ability.name.capitalized }.joined(separator: ", "))
        }
    }

    private func aboutRow(title: String, value: String) -> some View {
        HStack {
            Text("\(title):")
                .font(.custom("Poppins-SemiBold", size: 14))
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.custom("Poppins-Regular", size: 14))
                .foregroundColor(Color("TextColor"))
                .multilineTextAlignment(.leading)
        }
    }
}
