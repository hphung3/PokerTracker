//
//  Buyin.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/10/24.
//

import Foundation

struct Payment: Identifiable, Codable {
    let id: UUID
    var amount: Decimal
    var method: Method
    //var sender: Player
    //var recepient: Player
    
    init(id: UUID = UUID(), amount: Decimal, method: Method
        //,sender: Player, recepient: Player
    ) {
        self.id = id
        self.amount = amount
        self.method = method
        //self.sender = sender
        //self.recepient = recepient
    }
}

extension Payment {
    enum Method: String, Codable, CaseIterable, Identifiable {
        case Cash
        case Venmo
        
        var id: Self { self }
    }
}

extension Payment {
    static let exampleBuyin = Payment(amount: 20.00, 
                                      method: Payment.Method.Cash
                                      //sender: Player.samplePlayers[1],
                                      //recepient: Player.samplePlayers[0]
    )
    
    static let exampleCashout = Payment(amount: 50.00, 
                                        method: Payment.Method.Cash
                                        //sender: Player.samplePlayers[0],
                                        //recepient: Player.samplePlayers[1]
    )
}
