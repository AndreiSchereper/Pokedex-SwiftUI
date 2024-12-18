import SwiftUI

/// A customizable progress bar with dynamic color and progress.
struct ProgressBar: View {
    var progress: Double // Represents the progress value (0.0 to 1.0)
    var color: Color     // Color for the filled portion of the bar

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // Background Bar
                // Displays the unfilled portion of the bar in a light gray color with rounded corners.
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .cornerRadius(4)

                // Filled Portion (Foreground Bar)
                // Fills the progress bar proportionally to the `progress` value.
                // The color and corner radius match the design for a smooth appearance.
                Rectangle()
                    .fill(color)
                    .cornerRadius(4)
                    .frame(width: geometry.size.width * CGFloat(progress)) // Proportional width
            }
        }
        // Clip the edges to a rounded rectangle shape to ensure clean corners when full.
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}
