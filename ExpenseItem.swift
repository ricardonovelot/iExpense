//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Ricardo on 02/04/24.
//

import SwiftData
import Foundation

@Model
class ExpenseItem {
    let name: String
    let category: String
    let amount: Double
    
    init(name: String, category: String, amount: Double) {
        self.name = name
        self.category = category
        self.amount = amount
    }
}
