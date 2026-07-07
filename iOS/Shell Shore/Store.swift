import Foundation
import Combine

@MainActor
final class Store: ObservableObject {
    @Published var items: [ShellItem] = []
    @Published var isPro: Bool = false

    /// Free-tier cap. Always kept comfortably above seed data count so a
    /// fresh install never trips the paywall immediately.
    static let freeLimit = 15

    private let fileURL: URL

    init() {
        let support = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
        try? FileManager.default.createDirectory(at: support, withIntermediateDirectories: true)
        fileURL = support.appendingPathComponent("shellshore_items.json")
        load()
    }

    var canAddMore: Bool {
        isPro || items.count < Store.freeLimit
    }

    func add(_ item: ShellItem) {
        guard canAddMore else { return }
        items.insert(item, at: 0)
        save()
    }

    func update(_ item: ShellItem) {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[idx] = item
        save()
    }

    func delete(at offsets: IndexSet) {
        items.remove(atOffsets: offsets)
        save()
    }

    func delete(_ item: ShellItem) {
        items.removeAll { $0.id == item.id }
        save()
    }

    private func load() {
        if let data = try? Data(contentsOf: fileURL),
           let decoded = try? JSONDecoder().decode([ShellItem].self, from: data) {
            items = decoded
        } else {
            items = seedData()
            save()
        }
    }

    private func save() {
        guard let data = try? JSONEncoder().encode(items) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    private func seedData() -> [ShellItem] {
        [
        ShellItem(name: "Spiral Conch", beach: "Cocoa Beach", species: "Conch (guess)", dateFound: "2025-06-14"),
        ShellItem(name: "Speckled Cowrie", beach: "Sanibel Island", species: "Cowrie", dateFound: "2025-07-02"),
        ShellItem(name: "Fan Scallop", beach: "Local pier", species: "Scallop", dateFound: "2025-08-20")
        ]
    }
}
