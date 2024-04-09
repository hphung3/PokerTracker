//
//  NewGameSheet.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/23/24.
//

import SwiftUI

struct NewGameSheet: View {
    
    @Binding var isNewGameBeingCreated: Bool
    @Binding var games: [Game]
    let saveAction: () -> Void
    
    @State var gameName: String = ""
    
    var body: some View {
        VStack {
            Form {
                Section("New Game Name"){
                    TextField("Enter Game Name", text: $gameName)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel"){
                        isNewGameBeingCreated = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        games.insert(Game(date: Date(), name: gameName), at: 0)
                        saveAction()
                        isNewGameBeingCreated = false
                    }
                    .disabled(gameName.isEmpty)
                }
            }
            .padding(.top)
        }
    }
}

#Preview {
    NavigationStack {
        NewGameSheet(isNewGameBeingCreated: .constant(true), games: .constant([Game.sampleGame]), saveAction: {})
    }
}
