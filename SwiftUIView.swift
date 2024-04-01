//
//  SwiftUIView.swift
//  iExpense
//
//  Created by Ricardo on 09/12/23.
//


import SwiftUI

struct myView: View {
    @State private var numbers = Array(1...10)
    
    var oddNumbers: [Int] {
        numbers.filter { $0 % 2 != 0 }
    }
    
    var evenNumbers: [Int] {
        numbers.filter { $0 % 2 == 0 }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(oddNumbers.indices, id: \.self) { index in
                        Button(action: {
                            deleteNumber(at: index, isOdd: true)
                        }) {
                            Text("\(oddNumbers[index])")
                        }
                    }
                    .onDelete { indexSet in
                        deleteNumber(at: indexSet.first ?? 0, isOdd: true)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Odd Numbers")
                
                List {
                    ForEach(evenNumbers.indices, id: \.self) { index in
                        Button(action: {
                            deleteNumber(at: index, isOdd: false)
                        }) {
                            Text("\(evenNumbers[index])")
                        }
                    }
                    .onDelete { indexSet in
                        deleteNumber(at: indexSet.first ?? 0, isOdd: false)
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Even Numbers")
            }
        }
    }
    
    func deleteNumber(at index: Int, isOdd: Bool) {
        let filteredArray = isOdd ? oddNumbers : evenNumbers
        
        if let indexOfNumber = numbers.firstIndex(of: filteredArray[index]) {
            numbers.remove(at: indexOfNumber)
        }
    }
}




#Preview {
    myView()
}
