//
//  ContentView.swift
//  iExpense
//
//  Created by Ricardo on 15/11/23.
//

import SwiftUI
import SwiftData

@Model
class ExpenseItem {
    let name: String
    let type: String
    let amount: Double
    var id = UUID()
    
    init(name: String, type: String, amount: Double, id: UUID = UUID()) {
        self.name = name
        self.type = type
        self.amount = amount
        self.id = id
    }
}

struct ContentView: View {
    
    @State private var showingAddExpense = false
    
    @Environment(\.modelContext) var modelContext
    @Query var expenses: [ExpenseItem]
        
    var body: some View {
        NavigationView{
                List{
                    Section(header:Text("Personal")){
                        ForEach(expenses.filter {$0.type == "Personal"}){ item in
                            HStack{
                                VStack(alignment: .leading, content: {
                                    Text(item.name).font(.headline)
                                    Text(item.type)
                                })
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD" )).foregroundStyle(getColor(for: Int(item.amount)))
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                    Section(header:Text("Business")){
                        ForEach(expenses.filter {$0.type == "Business"}){ item in
                            HStack{
                                VStack(alignment: .leading, content: {
                                    Text(item.name).font(.headline)
                                    Text(item.type)
                                })
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD" )).foregroundStyle(getColor(for: Int(item.amount)))
                            }
                        }
                        .onDelete(perform: removeItems)
                    }
                }
            .navigationTitle("Expenses")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AddView()){
                        Image(systemName: "plus")
                    }
                }
            }
        }
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
        
        return ContentView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create container \(error.localizedDescription)")
    }
}
