import Foundation
import SwiftData

@Model
class FavoritePokemon {
    @Attribute(.unique) var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
