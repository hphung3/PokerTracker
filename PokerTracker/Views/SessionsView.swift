//
//  SessionsView.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/10/24.
//

import SwiftUI

struct SessionsView: View {
    @Binding var session: Session
    let saveAction: () -> Void
    
    var body: some View {
        List {
            Label("\(session.player.name)", systemImage: "person.fill")
            Section(header: Text("Buy Ins")) {
                NavigationLink(destination: AddPaymentView(title: "BuyIn for \(session.getPlayerName())", addAction: self.addBuyin)) {
                    Button("Add Buyin") {
                    }
                }
                ForEach($session.buyins) { $buyin in
                    NavigationLink(destination: EditPaymentView(payment: $buyin)) {
                        HStack {
                            Image(systemName: "dollarsign")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Image(systemName: "arrow.right")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Text("\(MoneyFormatter.formatDecimalToUS(decimal: buyin.amount)) via \(buyin.method.rawValue)")
                        }
                    }
                }
            }
            
            Section(header: Text("Cash Out")) {
                NavigationLink(destination: AddPaymentView(title: "Cash out for \(session.getPlayerName())", addAction: self.addCashout)){
                    Button("Add Cashout") {
                    }
                }
                ForEach($session.cashout) { $cashout in
                    NavigationLink(destination: EditPaymentView(payment: $cashout)) {
                        HStack{
                            Image(systemName: "dollarsign")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Image(systemName: "arrow.left")
                                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                            Text("\(MoneyFormatter.formatDecimalToUS(decimal: cashout.amount)) via \(cashout.method.rawValue)")
                        }
                    }

                }
            }
        }
        .navigationTitle("Player Overview")
        .onAppear() {
            saveAction()
        }
    }
    
    
    private func addCashout(payment: Payment) -> Void {
        session.cashout.append(payment)
    }
    
    private func addBuyin(payment: Payment) -> Void {
        session.buyins.append(payment)
    }
}

#Preview {
    NavigationStack {
        SessionsView(session: .constant(Session.exampleSession), saveAction: {})
    }
}
