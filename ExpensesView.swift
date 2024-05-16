//
//  ExpensesView.swift
//  iExpense
//
//  Created by Ricardo on 02/04/24.
//

import SwiftUI
import SwiftData

struct ExpensesView: View {
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
    
    var body: some View {
        List(expenses){ item in
            HStack{
                VStack(alignment: .leading, content: {
                    Text(item.name).font(.headline)
                    Text(item.category)
                })
                Spacer()
                
                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD" )).foregroundStyle(getColor(for: Int(item.amount)))
            }
        }
        .onAppear(perform: addSample)
    }

    init(categorySelection: String, sortOrder:[SortDescriptor<ExpenseItem>]){
        _expenses = Query(filter: #Predicate<ExpenseItem>{expense in
            if categorySelection == "All" {
                true
            } else {
                expense.category == categorySelection
            }
        }, sort: sortOrder)
    }
    
    func addSample(){
        do {
            try modelContext.delete(model: ExpenseItem.self)
        } catch {
            print("Failed to delete Expenses.")
        }
        
        let expense1 = ExpenseItem(name: "Car", category: "Business", amount: 10.0)
        modelContext.insert(expense1)
        let expense2 = ExpenseItem(name: "Gas", category: "Personal", amount: 20.0)
        modelContext.insert(expense2)
        let expense3 = ExpenseItem(name: "Food", category: "Personal", amount: 50.0)
        modelContext.insert(expense3)
        let expense4 = ExpenseItem(name: "Travel", category: "Business", amount: 80.0)
        modelContext.insert(expense4)
    }
    
    func removeItems(at offsets: IndexSet) {
        for offset in offsets {
            // find this book in our query
            let expense = expenses[offset]
            // delete it from the context
            modelContext.delete(expense)
        }
    }
    
    
    func getColor(for number: Int) -> Color {
        if number < 10 {
            return .blue
        } else if number < 100 {
            return .green
        } else {
            return .red
        }
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        
        return ExpensesView(categorySelection:"All",sortOrder:[SortDescriptor(\ExpenseItem.name)])
            .modelContainer(container)
    } catch {
        return Text("Failed to create container \(error.localizedDescription)")
    }
}
