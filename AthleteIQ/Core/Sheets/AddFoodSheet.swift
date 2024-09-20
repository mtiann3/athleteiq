import SwiftUI
import SwiftData

struct AddFoodSheet: View {
    @State private var foodName: String = "" // Name of the food
    @State private var foodDate = Date() // Default to today
    @State private var carbs: Int = 0
    @State private var fats: Int = 0
    @State private var protein: Int = 0
    @Environment(\.presentationMode) var presentationMode // To dismiss the sheet
    @Environment(\.modelContext) private var context // Access the SwiftData context

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Food Information")) {
                    TextField("Food Name", text: $foodName)
                    
                    DatePicker("Date", selection: $foodDate, displayedComponents: .date)
                    
                    HStack {
                        Text("Carbs (g):")
                        Spacer()
                        TextField("Carbs", value: $carbs, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Fats (g):")
                        Spacer()
                        TextField("Fats", value: $fats, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Protein (g):")
                        Spacer()
                        TextField("Protein", value: $protein, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section {
                    Button(action: saveFoodData) {
                        Text("Save")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Add Food Data")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func saveFoodData() {
        let foodEntry = Food(name: foodName, date: foodDate, carbs: carbs, fat: fats, protein: protein)
        
        context.insert(foodEntry) // Insert the food entry into the context

        do {
            try context.save() // Save the context to persist the data
            print("Food data saved for \(foodDate): \(carbs)g carbs, \(fats)g fats, \(protein)g protein")
            presentationMode.wrappedValue.dismiss() // Dismiss the sheet after saving
        } catch {
            print("Failed to save food data: \(error.localizedDescription)")
            // You might want to show an alert here if saving fails
        }
    }
}

#Preview {
    AddFoodSheet()
}
