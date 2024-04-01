//
//  iExpenseApp.swift
//  iExpense
//
//  Created by Ricardo on 15/11/23.
//

import SwiftUI

@main
struct iExpenseApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ExpenseItem.self)
    }
}
