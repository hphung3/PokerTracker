//
//  AddSessionView.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/25/24.
//

import SwiftUI

struct AddSessionView: View {
    @Binding var sessions: [Session]
    
    @State var playerName = ""
    @State var amount: Decimal?
    @State var paymentMethodSelection = Payment.Method.Cash
    
    @Environment(\.dismiss) var dismiss
    
    let saveAction: () -> Void
    
    var body: some View {
        Form {
            
            Section(header: Text("Player Name")){
                TextField("Enter Player Name", text: $playerName)
            }
            Section(header: Text("Buyin amount")) {
                TextField("Enter Amount", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                Picker("Payment Method", selection: $paymentMethodSelection) {
                    ForEach(Payment.Method.allCases) { method in
                        Text(method.rawValue)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Button("Add") {
                let newPlayer = Player(name: playerName)
                let newBuyin = Payment(amount: amount!, method: paymentMethodSelection)
                
                sessions.append(Session(
                                   player: newPlayer,
                                   buyins: [newBuyin],
                                   cashout: [])
                )
                saveAction()
                dismiss()
            }
            .disabled(amount == nil)
        }
        
    }
}

#Preview {
    AddSessionView(
        sessions: .constant(Session.sampleSessions), saveAction: {})
}
