//
//  DetailedGameView.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/19/24.
//

import SwiftUI

struct DetailedGameView: View {
    @Binding var game: Game
    let saveAction: () -> Void
    
    var body: some View {
        List {
            Text("Total Buyin: \(MoneyFormatter.formatDecimalToUS(decimal: getTotalBuyins(sessions: game.sessions)))")
            Text("Total Cashout: \(MoneyFormatter.formatDecimalToUS(decimal: getTotalCashOuts(sessions: game.sessions)))")
            Text(getPotPayoutText(buyinAmount: getTotalBuyins(sessions: game.sessions), cashoutAmount: getTotalCashOuts(sessions: game.sessions)))
                .listRowBackground(determineBackgroundColor(difference: getTotalBuyins(sessions: game.sessions) - getTotalCashOuts(sessions: game.sessions)))
            
            Section("Players") {
                ForEach($game.sessions) { $session in
                    NavigationLink(destination: SessionsView(session: $session, saveAction: saveAction)) {
                        Text("\(session.player.name) | In \(MoneyFormatter.formatDecimalToUS(decimal: getTotalAmountFromPayments(payments:session.buyins))) | Out \(MoneyFormatter.formatDecimalToUS(decimal: getTotalAmountFromPayments(payments:session.cashout)))\nNet \(MoneyFormatter.formatDecimalToUS(decimal: getTotalAmountFromPayments(payments: session.cashout)-getTotalAmountFromPayments(payments:session.buyins)))" )
                        
                    }
                    .listRowBackground(determineBackgroundColor(session: session))
                }
            }
        }
        .toolbar {
            NavigationLink {
                // destination view to navigation to
                AddSessionView(sessions: $game.sessions, saveAction: saveAction)
            } label: {
                Label("Add Player", systemImage: "person.fill.badge.plus")
            }
        }
    }
}

extension DetailedGameView {
    func getTotalAmountFromPayments(payments: [Payment]) -> Decimal {
        payments.reduce(0.0, { x, payment in x + payment.amount })
    }
    
    func getTotalBuyins(sessions: [Session]) -> Decimal {
        var totalAmount: Decimal = 0.0
        for session in sessions {
            totalAmount = totalAmount + getTotalAmountFromPayments(payments: session.buyins)
        }
        return totalAmount
    }
    
    func getTotalCashOuts(sessions: [Session]) -> Decimal {
        var totalAmount: Decimal = 0.0
        for session in sessions {
            totalAmount = totalAmount + getTotalAmountFromPayments(payments: session.cashout)
        }
        return totalAmount
    }
    
    func determineBackgroundColor(session: Session) -> Color {
        let difference = getTotalAmountFromPayments(payments: session.cashout) - getTotalAmountFromPayments(payments: session.buyins)
        return determineBackgroundColor(difference: difference)
    }
    
    func determineBackgroundColor(difference: Decimal) -> Color {
        if (difference < 0) {
            return Color.red
        }
        else if (difference > 0){
            return Color.green
        }
        else {
            return Color.gray
        }
    }
    
    func getPotPayoutText(buyinAmount: Decimal, cashoutAmount: Decimal) -> String {
        if (buyinAmount > cashoutAmount){
            return "Underpaid by \(buyinAmount - cashoutAmount)"
        } else if (cashoutAmount > buyinAmount) {
            return "Overpaid by \(cashoutAmount - buyinAmount)"
        } else {
            return "All good!"
        }
    }
}

#Preview {
    let game = Game(date: Date().advanced(by: TimeInterval(100000)), sessions: [Session.exampleSession, Session.exampleSession1], name: "Detailed Game")
    return NavigationStack {
        DetailedGameView(game: .constant(game), saveAction: {})
    }
}
