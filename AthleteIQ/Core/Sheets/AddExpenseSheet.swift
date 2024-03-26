import SwiftUI
import SwiftData

struct AddExpenseSheet: View {
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedNameIndex = 0
    @State private var date: Date = .now
    @State private var value: Double = 0
    
    // Import the expenseNames array
//    let exerciseNames = expenseNames
    let names = exerciseNames

    var body: some View {
        NavigationView {
            Form {
                Picker("Exercise Name", selection: $selectedNameIndex) {
                    ForEach(0..<exerciseNames.count, id: \.self) { index in
                        Text(self.names[index])
                    }
                }
                DatePicker("Date", selection: $date, displayedComponents: .date)
                TextField("Value", value: $value, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
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
                        let expense = Expense(name: selectedName, date: date, value: value)
                        context.insert(expense)
                        try! context.save() // Save the context after inserting the expense
                        dismiss()
                    }) {
                        Label("Save", systemImage: "")
                    }
                }
            }
        }
    }
}
