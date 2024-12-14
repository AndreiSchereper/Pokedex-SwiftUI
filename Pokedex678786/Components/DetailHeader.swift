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

            // Types (Now Left-Aligned)
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    ForEach(details.types, id: \.type.name) { type in
                        Text(type.type.name.capitalized)
                            .font(.custom("Poppins-SemiBold", size: 14))
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 4)
                            .background(typeColor(for: type.type.name)) // Use the global function
                            .cornerRadius(16)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading) // Ensure left alignment

            // Sprites (Front and Back)
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
}
