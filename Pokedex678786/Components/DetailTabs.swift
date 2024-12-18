import SwiftUI

/// A tab selector for the Pokémon detail view, with dynamically styled tabs based on type color.
struct DetailTabs: View {
    @Binding var selectedTab: String // Tracks the currently selected tab
    let typeColor: Color // The color used for the selected tab, based on Pokémon type

    var body: some View {
        HStack {
            tabButton(title: "About") // Tab for "About" section
            Spacer() // Spacer for even spacing
            tabButton(title: "Stats") // Tab for "Stats" section
            Spacer() // Spacer for even spacing
            tabButton(title: "Evolution") // Tab for "Evolution" section
        }
        .padding(.top, 16) // Add padding at the top for alignment
    }

    /// Creates a button for each tab, dynamically styled based on selection.
    private func tabButton(title: String) -> some View {
        Button(action: { selectedTab = title }) { // Update the selected tab on tap
            Text(title) // Tab label
                .font(.custom("Poppins-SemiBold", size: 16)) // Custom font for the tab text
                .foregroundColor(selectedTab == title ? .white : .gray) // Highlight selected tab
                .padding(.horizontal, 20) // Horizontal padding for the button
                .padding(.vertical, 10) // Vertical padding for the button
                .background(selectedTab == title ? typeColor : Color.gray.opacity(0.2)) // Dynamic color for selected tab
                .cornerRadius(16) // Rounded corners for the button
        }
    }
}
