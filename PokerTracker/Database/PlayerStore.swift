//
//  PlayerStore.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/12/24.
//

import Foundation

class PlayerStore: ObservableObject {
    @Published var players: [Player] = []
    
    private static func fileUrl() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent("players.data")
    }
    
    func loadPlayers() async throws {
        let task = Task<[Player], Error> {
            let fileUrl = try Self.fileUrl()
            guard let data = try? Data.init(contentsOf: fileUrl) else {
                return []
            }
            let players = try JSONDecoder().decode([Player].self, from: data)
            return players
        }
        let loadedPlayers = try await task.value
        self.players = loadedPlayers
    }
    
    func savePlayers(players:[Player]) async throws {
        let task = Task {
            let data = try JSONEncoder().encode(players)
            let outfile = try Self.fileUrl()
            try data.write(to: outfile)
        }
        _ = try await task.value
    }
}
