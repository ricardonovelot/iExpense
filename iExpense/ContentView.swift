//
//  ContentView.swift
//  iExpense
//
//  Created by Ricardo on 15/11/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @State private var showingAddExpense = false
    @State private var categories: [(emoji: String, name: String)] = [
        ("📋", "All"),
        ("🏠", "Personal"),
        ("💼", "Business")
    ]
    @State private var categorySelection = "All"
    @State private var sortOrded = [
        SortDescriptor(\ExpenseItem.name),
        SortDescriptor(\ExpenseItem.category)
    ]
   
    
    var body: some View {
        NavigationView{
            ExpensesView(categorySelection:categorySelection,sortOrder: sortOrded)
                .navigationTitle("Expenses")
                .toolbar {
                    ToolbarItem(placement:.principal, content: {
                        Picker("Filter", selection: $categorySelection) {
                            ForEach(categories, id:\.name){ category in
                                Text("\(category.emoji)")
                            }
                        }.pickerStyle(.segmented)
                    })

                    
                    ToolbarItemGroup(placement: .topBarTrailing, content: {
                        Picker("Sort", selection: $sortOrded) {
                            Text("Sort by Name")
                                .tag([
                                    SortDescriptor(\ExpenseItem.name),
                                    SortDescriptor(\ExpenseItem.amount)
                                ])
                            Text("Sort by Amount")
                                .tag([
                                    SortDescriptor(\ExpenseItem.amount),
                                    SortDescriptor(\ExpenseItem.name)
                                ])
                        }
                        NavigationLink(destination: AddView()){
                            Image(systemName: "plus")
                        }
                    })
                }
        }
    }
    
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        
        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create container \(error.localizedDescription)")
    }
}
