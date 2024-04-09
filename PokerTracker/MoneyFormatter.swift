//
//  MoneyFormatter.swift
//  PokerTracker
//
//  Created by Harrison Phung on 3/17/24.
//

import Foundation

class MoneyFormatter {
    
    static let formatter: NumberFormatter = createFormatter()
    
    static private func createFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.currencyCode = "USD"
        formatter.numberStyle = .currency
        return formatter
    }
    
    public static func formatDecimalToUS(decimal: Decimal) -> String {
        return formatter.string(for: decimal) ?? ""
    }

}
