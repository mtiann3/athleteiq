//
//  AddExerciseSheet.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/26/24.
//

import SwiftUI
import SwiftData

struct AddExerciseSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedNameIndex = 0
    @State private var date: Date = .now
    @State private var weight: Int = 0
    @State private var reps: Int = 0
    @State private var sets: Int = 0

    
    // Import the expenseNames array
    let names = exerciseNames

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Details")) {
                    Picker("Exercise Name", selection: $selectedNameIndex) {
                        ForEach(0..<exerciseNames.count, id: \.self) { index in
                            Text(self.names[index])
                        }
                    }
                    .bold()

                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .bold()

                    HStack {
                        Text("Weight")
                            .bold()
                        Spacer()
                        TextField("Lbs", value: $weight, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("Repetitions:")
                            .bold()
                        Spacer()
                        TextField("Number", value: $reps, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                    HStack {
                        Text("Sets:")
                            .bold()
                        Spacer()
                        TextField("Number", value: $sets, formatter: NumberFormatter())
                            .keyboardType(.numberPad)
                    }
                }
            }
            .navigationTitle("New Exercise")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let selectedName = self.names[selectedNameIndex]
                        let exercise = Exercise(name: selectedName, date: date, weight: weight, repetitions: reps, sets: sets)
                        context.insert(exercise)
                        try! context.save()
                        dismiss()
                    }) {
                        Text("Save")
                    }
                }
            }

        }
    }
}
