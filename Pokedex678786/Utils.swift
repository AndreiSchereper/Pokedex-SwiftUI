import SwiftUI

/// Returns the corresponding color for a given Pokémon type.
func typeColor(for type: String) -> Color {
    // Map of Pokémon types to their colors
    let typeColors: [String: Color] = [
        "normal": Color(red: 168 / 255, green: 167 / 255, blue: 122 / 255),
        "fire": Color(red: 238 / 255, green: 129 / 255, blue: 48 / 255),
        "water": Color(red: 99 / 255, green: 144 / 255, blue: 240 / 255),
        "electric": Color(red: 247 / 255, green: 208 / 255, blue: 44 / 255),
        "grass": Color(red: 122 / 255, green: 199 / 255, blue: 76 / 255),
        "ice": Color(red: 150 / 255, green: 217 / 255, blue: 214 / 255),
        "fighting": Color(red: 194 / 255, green: 46 / 255, blue: 40 / 255),
        "poison": Color(red: 163 / 255, green: 62 / 255, blue: 161 / 255),
        "ground": Color(red: 226 / 255, green: 191 / 255, blue: 101 / 255),
        "flying": Color(red: 169 / 255, green: 143 / 255, blue: 243 / 255),
        "psychic": Color(red: 249 / 255, green: 85 / 255, blue: 135 / 255),
        "bug": Color(red: 166 / 255, green: 185 / 255, blue: 26 / 255),
        "rock": Color(red: 182 / 255, green: 161 / 255, blue: 54 / 255),
        "ghost": Color(red: 115 / 255, green: 87 / 255, blue: 151 / 255),
        "dragon": Color(red: 111 / 255, green: 53 / 255, blue: 252 / 255),
        "dark": Color(red: 112 / 255, green: 87 / 255, blue: 70 / 255),
        "steel": Color(red: 183 / 255, green: 183 / 255, blue: 206 / 255),
        "fairy": Color(red: 214 / 255, green: 133 / 255, blue: 173 / 255)
    ]
    // Return the color for the type or gray if type is unknown
    return typeColors[type.lowercased(), default: .gray]
}
