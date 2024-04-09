//
//  GamesView.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/18/24.
//

import SwiftUI

struct GamesView: View {
    @Binding var games: [Game]
    @State var isNewGameBeingCreated: Bool = false
    let saveAction: () -> Void
    
    func formatDate(date: Date) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "MM/dd/yyyy HH:mm"
        return inputFormatter.string(from: date)
    }
    
    var body: some View {
        NavigationStack {
            List($games) { $game in
                NavigationLink {
                    DetailedGameView(game: $game, saveAction: saveAction)
                } label: {
                    Label("\(game.name) - \(formatDate(date: game.date))", systemImage: "suit.spade.fill")
                }
            }
            .toolbar {
                Button(){
                    isNewGameBeingCreated = true
                } label: {
                    Text("New Game")
                }
            }
        }
        .sheet(isPresented: $isNewGameBeingCreated) {
            NavigationStack {
                NewGameSheet(isNewGameBeingCreated: $isNewGameBeingCreated, games: $games, saveAction: saveAction)
            }
        }
    }
}

#Preview {
    let game1 = Game(date: Date().advanced(by: TimeInterval(100000)), sessions: [Session.exampleSession, Session.exampleSession1], name: "Game 1")
    let game2 = Game(date: Date(), sessions: [Session.exampleSession, Session.exampleSession1], name: "Game 2")
    let games = [game1, game2]
    return GamesView(games: .constant(games)) {
        
    }
}
