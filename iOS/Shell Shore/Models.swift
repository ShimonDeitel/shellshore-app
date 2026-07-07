import Foundation

struct ShellItem: Identifiable, Codable, Equatable {
    var id: UUID
    var dateAdded: Date
    var name: String
    var beach: String
    var species: String
    var dateFound: String

    init(id: UUID = UUID(), dateAdded: Date = Date(), name: String, beach: String, species: String, dateFound: String) {
        self.id = id
        self.dateAdded = dateAdded
        self.name = name
        self.beach = beach
        self.species = species
        self.dateFound = dateFound
    }

    static func blank() -> ShellItem {
        ShellItem(name: "", beach: "", species: "", dateFound: "")
    }
}
