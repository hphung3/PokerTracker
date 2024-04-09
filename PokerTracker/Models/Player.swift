//
//  Player.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/10/24.
//

import Foundation

struct Player: Identifiable, Codable {
    let id: UUID
    var name: String
    var username: String?
    
    init(id: UUID = UUID(), name: String, username: String = "") {
        self.id = id
        self.name = name
        self.username = username
    }
}

extension Player {
    static let samplePlayers: [Player] = [
        Player(name: "Harrison", username: "harrisonphung"),
        Player(name: "Bryan", username: "bryguy"),
        Player(name: "Gramps", username: "OldMan")
    ]
}
