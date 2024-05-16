//
//  AddView.swift
//  iExpense
//
//  Created by Ricardo on 04/12/23.
//

import SwiftUI
import SwiftData

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var name = "New Expense"
    @State private var category = "Personal"
    @State private var amount = 0.0

    
    let types = ["Business", "Personal"]
    
    var body: some View {
            Form{
                Section{
                    TextField("Name", text: $name)
                    TextField("Amount", value: $amount, format: .currency(code: "USD")).keyboardType(.decimalPad)
                    Picker("Category", selection: $category){
                        ForEach(types, id: \.self){
                            Text($0)
                        }
                    }
                }
            }.navigationTitle($name)
                .navigationBarItems(
                    trailing: 
                        Button("Save", action: saveEntry)
            )
            .navigationBarTitleDisplayMode(.inline)
    }
    
    private func saveEntry(){
        let item = ExpenseItem(name: name, category: category, amount: amount)
        modelContext.insert(item)
        dismiss()
    }
}

#Preview {
    
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: ExpenseItem.self, configurations: config)
        
        return AddView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create container \(error.localizedDescription)")
    }

}
