//
//  Session.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/12/24.
//

import Foundation

struct Session: Identifiable, Codable {
    let id: UUID
    var player: Player
    var buyins: [Payment]
    var cashout: [Payment]
    
    init(id: UUID = UUID(), player: Player, buyins: [Payment] = [], cashout: [Payment] = []) {
        self.id = id
        self.player = player
        self.buyins = buyins
        self.cashout = cashout
    }
    
    public func getPlayerName() -> String {
        return player.name
    }
    

}

extension Session {
    static let exampleSession = Session(player: Player.samplePlayers[0], 
                                        buyins: [Payment.exampleBuyin],
                                        cashout: [Payment.exampleCashout])
    static let exampleSession1 = Session(player: Player.samplePlayers[1],
                                        buyins: [Payment.exampleBuyin],
                                        cashout: [Payment.exampleCashout])
    static let sampleSessions = [exampleSession, exampleSession1]
}
