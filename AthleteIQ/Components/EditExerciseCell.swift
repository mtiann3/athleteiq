//
//  EditExerciseCell.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/26/24.
//

//
//  EditExpenseCell.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/26/24.
//

import SwiftUI

struct EditExerciseCell: View {
    
    let exercise: Exercise
    
    var body: some View {
        HStack(spacing: 10) {
            Text(formatDate(exercise.date))
                .frame(width: 70, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("\(exercise.sets) x \(exercise.repetitions) Reps")
                    .font(.headline)
                Text(exercise.name)
                    .font(.body)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(exercise.weight)) lbs")
                    .font(.headline)
//                Text(" X \(exercise.sets)")
//                    .font(.body)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .shadow(color: Color.red.opacity(0.4), radius: 5, x: 2, y: 2)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd" // Customize the date format as per your need
        return formatter.string(from: date)
    }
}
