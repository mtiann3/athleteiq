//
//  AddCardioSheet.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 9/19/24.
//

import SwiftUI

struct AddCardioSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var date: Date = .now
    @State private var time: Double = 0
    @State private var caloriesBurned: Int = 0

    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Exercise Details")) {
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                        .bold()

                    HStack {
                        Text("Time")
                            .bold()
                        Spacer()
                        TextField("(min)", value: $time, formatter: NumberFormatter())
                            .keyboardType(.decimalPad)
                    }
                    HStack {
                        Text("Calories Burned:")
                            .bold()
                        Spacer()
                        TextField("Number", value: $caloriesBurned, formatter: NumberFormatter())
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
                        let cardio = Cardio(date: date, time: time, caloriesBurned: caloriesBurned)
                        context.insert(cardio)
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
