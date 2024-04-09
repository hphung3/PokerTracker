//
//  GameStore.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/12/24.
//


import Foundation

@MainActor
class GameStore: ObservableObject {
    @Published var games: [Game] = []
    
    private static func fileUrl() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("games.data")
    }
    
    func loadGame() async throws {
        let task = Task<[Game], Error> {
            let fileUrl = try Self.fileUrl()
            guard let data = try? Data.init(contentsOf: fileUrl) else {
                return []
            }
            let games = try JSONDecoder().decode([Game].self, from: data)
            return games
        }
        var loadedGames = try await task.value
        loadedGames.sort(by: {x, y in x.date > y.date})
        self.games = loadedGames
    }
    
    func saveGames(gamesToSave: [Game]) async throws {
        //todo: optimize to save just a game
        let task = Task {
            let data = try JSONEncoder().encode(gamesToSave)
            let outfile = try Self.fileUrl()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
