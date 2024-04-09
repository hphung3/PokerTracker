//
//  Session.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/10/24.
//

import Foundation

struct Game: Identifiable, Codable {
    let id: UUID
    var date: Date
    var sessions: [Session]
    var name: String
    
    init(id: UUID = UUID(), date: Date, sessions: [Session] = [], name: String) {
        self.id = id
        self.date = date
        self.sessions = sessions
        self.name = name
    }
}

extension Game {
    static let sampleGame = Game(date: Date(), sessions: [Session.exampleSession], name: "Home Game")
}
