import SwiftUI

struct ExerciseCell: View {
    
    let exercise: Exercise
    
    var body: some View {
        HStack(spacing: 10) {
            Text(formatDate(exercise.date))
                .frame(width: 70, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
//                Text("2 Sets of")
//                    .font(.headline)
                Text(exercise.name)
                    .font(.body)
                    .bold()
            }
            
            Spacer()
            Text("View progress")
                .foregroundColor(Color.blue)
                .font(.title3)
                .bold()
            
            VStack(alignment: .trailing, spacing: 4) {
//                Text("\(Int(expense.value)) lbs")
//                    .font(.headline)
//                Text(" X 1")
//                    .font(.body)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color(.systemGray5))
        .cornerRadius(10)
        .shadow(color: Color.blue.opacity(0.4), radius: 5, x: 2, y: 2)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd" // Customize the date format as per your need
        return formatter.string(from: date)
    }
}
