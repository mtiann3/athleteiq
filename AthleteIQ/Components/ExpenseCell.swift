import SwiftUI

struct ExpenseCell: View {
    
    let expense: Expense
    
    var body: some View {
        HStack(spacing: 10) {
            Text(formatDate(expense.date))
                .frame(width: 70, alignment: .leading)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("2 Sets of")
                    .font(.headline)
                Text(expense.name)
                    .font(.body)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(Int(expense.value)) lbs")
                    .font(.headline)
                Text(" X 1")
                    .font(.body)
            }
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
    
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd" // Customize the date format as per your need
        return formatter.string(from: date)
    }
}
