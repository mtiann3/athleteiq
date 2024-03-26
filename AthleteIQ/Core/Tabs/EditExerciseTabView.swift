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
    @Query(sort: \Exercise.date)
    var exercises: [Exercise]
    @State private var exerciseToEdit: Exercise?
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(exercises.sorted(by: { $0.date > $1.date })) { exercise in
                        EditExerciseCell(exercise: exercise)
                            .onTapGesture {
                                exerciseToEdit = exercise
                            }
                    }
                    .onDelete { indexSet in
                        let sortedExercises = exercises.sorted(by: { $0.date > $1.date })
                        for index in indexSet {
                            let exerciseToDelete = sortedExercises[index]
                            if let originalIndex = exercises.firstIndex(where: { $0.id == exerciseToDelete.id }) {
                                context.delete(exercises[originalIndex])
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
                if exercises.isEmpty {
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
        .sheet(item: $exerciseToEdit) { exercise in
            UpdateExerciseSheet(exercise: exercise)
//            UpdateExpenseSheet(expense: expense)
        }
    }
}
