//
//  Ext.swift
//  Forecast
//
//  Created by Akezhan Sauirbayev  on 14.04.2024.
//

import Foundation
extension Double {
    func formatAsCurrency(amount: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "USD"
        let usLocale = Locale(identifier: "en_US")
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = usLocale
        return numberFormatter.string(from: NSNumber(value: amount))!
    }
    func formatAsCurrency(input: String) -> Double? {
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyCode = "USD"
        let usLocale = Locale(identifier: "en_US")
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 2
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = usLocale
        return numberFormatter.number(from: input)?.doubleValue
    }
    
    
}
