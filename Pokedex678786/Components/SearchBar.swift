import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack {
            // Search Icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("TextColor"))

            // Search Input
            TextField("Search Pokémon", text: $text)
                .font(.custom("Poppins-Regular", size: 16))
                .focused($isFocused)
                .onSubmit {
                    dismissKeyboard()
                }

            // Clear Button
            if !text.isEmpty {
                Button(action: clearSearch) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color("TextColor"))
                }
            }
        }
        .padding(10)
        .background(Color("CardColor"))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }

    // Clear Search Query
    private func clearSearch() {
        text = ""
        dismissKeyboard()
    }

    // Helper to Dismiss the Keyboard
    private func dismissKeyboard() {
        isFocused = false
    }
}
