import SwiftUI
import SwiftData

struct UpdateExpenseSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Bindable var expense: Expense
    @State private var selectedNameIndex = 0
    
    // Import the expenseNames array
    let exerciseNames = expenseNames

   
    var body: some View {
        NavigationStack {
            Form {
                Picker("Exercise Name", selection: $expense.name) {
                    ForEach(exerciseNames, id: \.self) { exerciseName in
                        Text(exerciseName)
                    }
                }
                TextField("Expense Name", text: $expense.name)
                DatePicker("Date", selection: $expense.date, displayedComponents: .date)
                TextField("Value", value: $expense.value, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Update Expense")
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
