import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool // Manage keyboard focus

    var body: some View {
        HStack {
            // Search Icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("TextColor"))
            // TextField for search
            TextField("Search Pokémon", text: $text)
                .font(.custom("Poppins-Regular", size: 16))
                .focused($isFocused) // Bind to keyboard focus state
                .onSubmit {
                    dismissKeyboard() // Dismiss keyboard on enter/return
                }

            // Clear Button (X Icon)
            if !text.isEmpty {
                Button(action: {
                    text = ""
                    dismissKeyboard()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color("TextColor"))
                }
            }
        }
        .padding(10)
        .background(Color("CardColor")) // Pure white background
        .cornerRadius(12) // Smooth corners
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Subtle shadow for depth
        .padding(.horizontal)
        .onTapGesture {
            isFocused = true // Bring up the keyboard when tapped
        }
    }

    // Helper to dismiss the keyboard
    private func dismissKeyboard() {
        isFocused = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
