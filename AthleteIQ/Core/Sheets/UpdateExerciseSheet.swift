//
//  UpdateExerciseSheet.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/26/24.
//

import SwiftUI
import SwiftData

struct UpdateExerciseSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var exercise: Exercise
    @State private var selectedNameIndex = 0
    
    // Import the expenseNames array
//    let exerciseNames = expenseNames
    let names = exerciseNames

   
    var body: some View {
        NavigationStack {
            Form {
                Picker("Exercise Name:", selection: $exercise.name) {
                    ForEach(names, id: \.self) { exerciseName in
                        Text(exerciseName)
                    }
                }
                .bold()

//                TextField("Expense Name", text: $exercise.name)
                DatePicker("Date:", selection: $exercise.date, displayedComponents: .date)
                    .bold()

                HStack{
                    Text("Weight:")
                        .bold()

                    TextField("Lbs:", value: $exercise.weight, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                HStack{
                    Text("Sets:")
                        .bold()
                    TextField("Number", value: $exercise.sets, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
                HStack{
                    Text("Repetitions:")
                        .bold()
                    TextField("Number", value: $exercise.repetitions, formatter: NumberFormatter())
                        .keyboardType(.decimalPad)
                }
            }
            .navigationTitle("Update Exercise")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done"){ dismiss() }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
