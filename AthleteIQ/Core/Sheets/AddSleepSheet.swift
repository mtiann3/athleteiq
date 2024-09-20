import SwiftUI
import SwiftData

struct AddSleepSheet: View {
    @State private var sleepDate = Date() // Default to today
    @State private var hoursOfSleep: Int = 8 // Default value for hours of sleep
    @Environment(\.presentationMode) var presentationMode // To dismiss the sheet
    @Environment(\.modelContext) private var context // Access the SwiftData context

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Sleep Information")) {
                    DatePicker("Date", selection: $sleepDate, displayedComponents: .date)
                    
                    Stepper(value: $hoursOfSleep, in: 1...24) {
                        Text("Hours of Sleep: \(hoursOfSleep)")
                    }
                }
                
                Section {
                    Button(action: saveSleepData) {
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
            .navigationTitle("Add Sleep Data")
            .navigationBarItems(leading: Button("Cancel") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func saveSleepData() {
        let sleepEntry = Sleep(date: sleepDate, time: Double(hoursOfSleep))
        
        context.insert(sleepEntry) // Insert the sleep entry into the context

        do {
            try context.save() // Save the context to persist the data
            print("Sleep data saved: \(hoursOfSleep) hours on \(sleepDate)")
            presentationMode.wrappedValue.dismiss() // Dismiss the sheet after saving
        } catch {
            print("Failed to save sleep data: \(error.localizedDescription)")
            // You might want to show an alert here if saving fails
        }
    }
}
