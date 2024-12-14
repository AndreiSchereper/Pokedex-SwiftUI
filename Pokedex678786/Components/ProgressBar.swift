import SwiftUI

struct ProgressBar: View {
    var progress: Double
    var color: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .cornerRadius(4)
                
                // Foreground Bar
                Rectangle()
                    .fill(color)
                    .frame(width: min(geometry.size.width, geometry.size.width * CGFloat(progress))) // Clamp width
                    .cornerRadius(progress < 1.0 || progress == 1.0 ? 4 : 4) // Keep rounded corners
            }
        }
    }
}
