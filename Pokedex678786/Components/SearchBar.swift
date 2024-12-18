import SwiftUI

/// A reusable search bar component with a text input field and clear functionality.
struct SearchBar: View {
    @Binding var text: String // Two-way binding for the search query
    @FocusState private var isFocused: Bool // Tracks keyboard focus state

    var body: some View {
        HStack {
            // Search Icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color("TextColor")) // Icon color from Assets

            // Search Input Field
            TextField("Search Pokémon", text: $text)
                .font(.custom("Poppins-Regular", size: 16)) // Custom font for input text
                .focused($isFocused) // Link focus state to the field
                .onSubmit {
                    dismissKeyboard() // Dismiss keyboard on return
                }

            // Clear Button (Visible only when text is not empty)
            if !text.isEmpty {
                Button(action: clearSearch) {
                    Image(systemName: "xmark.circle.fill") // Clear icon
                        .foregroundColor(Color("TextColor")) // Icon color from Assets
                }
            }
        }
        .padding(10) // Inner padding for the search bar
        .background(Color("CardColor")) // Background color from Assets
        .cornerRadius(12) // Smooth rounded corners
        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2) // Subtle shadow for depth
        .padding(.horizontal) // Horizontal padding for outer alignment
    }

    /// Clears the search query and dismisses the keyboard.
    private func clearSearch() {
        text = "" // Reset the search text
        dismissKeyboard() // Dismiss the keyboard
    }

    /// Dismisses the keyboard by changing the focus state.
    private func dismissKeyboard() {
        isFocused = false
    }
}
