import SwiftUI

func typeColor(for type: String) -> Color {
    switch type.lowercased() {
    case "normal": return Color(red: 168 / 255, green: 167 / 255, blue: 122 / 255)
    case "fire": return Color(red: 238 / 255, green: 129 / 255, blue: 48 / 255)
    case "water": return Color(red: 99 / 255, green: 144 / 255, blue: 240 / 255)
    case "electric": return Color(red: 247 / 255, green: 208 / 255, blue: 44 / 255)
    case "grass": return Color(red: 122 / 255, green: 199 / 255, blue: 76 / 255)
    case "ice": return Color(red: 150 / 255, green: 217 / 255, blue: 214 / 255)
    case "fighting": return Color(red: 194 / 255, green: 46 / 255, blue: 40 / 255)
    case "poison": return Color(red: 163 / 255, green: 62 / 255, blue: 161 / 255)
    case "ground": return Color(red: 226 / 255, green: 191 / 255, blue: 101 / 255)
    case "flying": return Color(red: 169 / 255, green: 143 / 255, blue: 243 / 255)
    case "psychic": return Color(red: 249 / 255, green: 85 / 255, blue: 135 / 255)
    case "bug": return Color(red: 166 / 255, green: 185 / 255, blue: 26 / 255)
    case "rock": return Color(red: 182 / 255, green: 161 / 255, blue: 54 / 255)
    case "ghost": return Color(red: 115 / 255, green: 87 / 255, blue: 151 / 255)
    case "dragon": return Color(red: 111 / 255, green: 53 / 255, blue: 252 / 255)
    case "dark": return Color(red: 112 / 255, green: 87 / 255, blue: 70 / 255)
    case "steel": return Color(red: 183 / 255, green: 183 / 255, blue: 206 / 255)
    case "fairy": return Color(red: 214 / 255, green: 133 / 255, blue: 173 / 255)
    default: return .gray
    }
}
