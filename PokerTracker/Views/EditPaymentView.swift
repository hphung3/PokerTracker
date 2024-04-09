//
//  EditPaymentView.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/28/24.
//

import SwiftUI

struct EditPaymentView: View {
    @Binding var payment: Payment
    @State private var paymentMethodSelection: Payment.Method = Payment.Method.Cash
    @State private var amount: Decimal = 0.0
    
    @Environment(\.dismiss) var dismiss
    
    init(payment: Binding<Payment>) {
        //might be anti-pattern, but using this for now
        self._payment = payment
        _paymentMethodSelection = State(initialValue: self.payment.method)
        _amount = State(initialValue: self.payment.amount)
    }
    
    var body: some View {
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
                payment.amount = self.amount
                payment.method = self.paymentMethodSelection
                dismiss()
            }
        }
    }
}

#Preview {
    NavigationStack {
        EditPaymentView(payment: .constant(Payment.exampleBuyin))
    }
}
