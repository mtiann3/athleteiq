//
//  ViewExerciseProgressSheet.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/25/24.
//

import SwiftUI
//
//This component will go through all of the exercises with the same name as the one selected,
//calculate an estimated one rep max for each based on sets, reps and weight,
//and will display a graph of the one rep maxes by that exercise entry.
//
struct ViewExerciseProgressSheet: View {
    let exercise: Exercise
        @Environment(\.presentationMode) var presentationMode

        var body: some View {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Close")
//                            .font(.title)
//                            .foregroundColor(.blue)
                    }
                    .padding()
                }

                
                Text("Exercise Progress")
                    .font(.title)
                
//                Spacer()
                
                
                Text("Name: \(exercise.name)")
                Text("Weight: \(exercise.weight) lbs")
                Text("Date: \(exercise.date)")
                // Add more details as needed
                
                Spacer()
            }
            .padding()
        }
    }
