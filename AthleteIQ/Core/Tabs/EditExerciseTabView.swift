//
//  EditExerciseTabView.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/25/24.
//

import SwiftUI
import SwiftData

struct EditExerciseTabView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @Query(sort: \Expense.date)
    var expenses: [Expense]
    @State private var expenseToEdit: Expense?
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(expenses.sorted(by: { $0.date > $1.date })) { expense in
                        ExpenseCell(expense: expense)
                            .onTapGesture {
                                expenseToEdit = expense
                            }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            context.delete(expenses[index])
                        }
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Your Expenses") // <- Title for the view
            .toolbar {
                // Your toolbar items
            }
            .overlay {
                if expenses.isEmpty {
                    VStack {
                        Spacer()
                        ContentUnavailableView(label: {
                            Label("No Exercises", systemImage: "dumbbell.fill")
                        }, description: {
                            Text("Start adding exercises to see your progress.")
                        }, actions: {
//                            Button("Add Exercise") {
//                                isShowingItemSheet = true
//                            }
                        })
                        .padding()
                        Spacer()
                    }
                }
            }
        }
        .sheet(item: $expenseToEdit) { expense in
            UpdateExpenseSheet(expense: expense)
        }
    }
}
