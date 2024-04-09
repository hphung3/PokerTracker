//
//  AddPaymentView.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/26/24.
//

import SwiftUI

struct AddPaymentView: View {
    @State var amount: Decimal?
    @State var paymentMethodSelection = Payment.Method.Cash
    let title: String
    let addAction: (Payment) -> Void
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Text(title)

        Form {
            Section(header: Text("Amount")) {
                TextField("Enter Amount", value: $amount, format: .number.precision(.fractionLength(2)))
                    .keyboardType(.decimalPad)
                Picker("Payment Method", selection: $paymentMethodSelection) {
                    ForEach(Payment.Method.allCases) { method in
                        Text(method.rawValue)
                    }
                }
                .pickerStyle(.menu)
            }
            
            Button("Confirm") {
                addAction(Payment(amount: amount!, method: paymentMethodSelection))
                dismiss()
            }
            .disabled(amount == nil)
        }
    }
}

#Preview {
    func action(payment: Payment) -> Void {
        
    }
    return AddPaymentView(
        title: "Add BuyIn for Harrison",
                   addAction: action
    )
}
