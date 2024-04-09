//
//  PokerTrackerApp.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/10/24.
//

import SwiftUI

@main
struct PokerTrackerApp: App {
    @StateObject private var gameStore = GameStore()
    
    var body: some Scene {
        WindowGroup {
            GamesView(games: $gameStore.games) {
                Task {
                    do {
                        try await gameStore.saveGames(gamesToSave: gameStore.games)
                    } catch {
                        
                    }
                }
            }
            .task {
                do {
                    try await gameStore.loadGame()
                } catch {
                    gameStore.games = [Game.sampleGame]
                }
            }
        }
    }
}
