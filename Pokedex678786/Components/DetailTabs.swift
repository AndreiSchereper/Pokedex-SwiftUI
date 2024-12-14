import SwiftUI

struct DetailTabs: View {
    @Binding var selectedTab: String

    var body: some View {
        HStack {
            tabButton(title: "About")
            Spacer()
            tabButton(title: "Stats")
            Spacer()
            tabButton(title: "Evolution")
        }
        .padding(.top, 16)
    }

    private func tabButton(title: String) -> some View {
        Button(action: { selectedTab = title }) {
            Text(title)
                .font(.custom("Poppins-SemiBold", size: 16))
                .foregroundColor(selectedTab == title ? .white : .gray)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(selectedTab == title ? Color("AccentColor") : Color.gray.opacity(0.2))
                .cornerRadius(16)
        }
    }
}
