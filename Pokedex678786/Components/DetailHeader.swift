import SwiftUI

struct DetailHeader: View {
    let details: PokemonDetails

    var body: some View {
        VStack(spacing: 16) {
            HStack(alignment: .center) {
                Text(details.name.capitalized)
                    .font(.custom("Poppins-SemiBold", size: 32))
                    .foregroundColor(Color("TextColor"))

                Spacer()

                Text(String(format: "#%03d", details.id))
                    .font(.custom("Poppins-Bold", size: 24))
                    .foregroundColor(.gray)
            }

            HStack(spacing: 8) {
                ForEach(details.types, id: \.type.name) { type in
                    Text(type.type.name.capitalized)
                        .font(.custom("Poppins-SemiBold", size: 14))
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 4)
                        .background(typeColor(for: type.type.name))
                        .cornerRadius(16)
                }
            }

            HStack(spacing: 16) {
                AsyncImage(url: URL(string: details.sprites.frontDefault ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)

                AsyncImage(url: URL(string: details.sprites.backDefault ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 150)
            }
        }
    }

    private func typeColor(for type: String) -> Color {
        switch type.lowercased() {
        case "grass": return .green
        case "poison": return .purple
        case "fire": return .red
        default: return .gray
        }
    }
}
