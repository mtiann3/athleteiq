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
                        EditExpenseCell(expense: expense)
                            .onTapGesture {
                                expenseToEdit = expense
                            }
                    }
                    .onDelete { indexSet in
                        let sortedExpenses = expenses.sorted(by: { $0.date > $1.date })
                        for index in indexSet {
                            let expenseToDelete = sortedExpenses[index]
                            if let originalIndex = expenses.firstIndex(where: { $0.id == expenseToDelete.id }) {
                                context.delete(expenses[originalIndex])
                            }
                        }
                    }
                }
            }

            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Your Exercise History") // <- Title for the view
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
