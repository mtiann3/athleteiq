import SwiftUI
import SwiftData
import Foundation

struct ExportDataSheet: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Exercise.date)
    var exercises: [Exercise]
    
    var body: some View {
        Text("Exporting...")
            .onAppear {
                exportCSV()
            }
    }

    func exportCSV() {
        let fileName = "exercise_data.csv"
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        var csvText = "Name,Date,Weight,Repetitions,Sets\n"
        for exercise in exercises {
            let name = exercise.name
            let date = formatDate(exercise.date)
            let weight = "\(exercise.weight)"
            let repetitions = "\(exercise.repetitions)"
            let sets = "\(exercise.sets)"
            let newLine = "\(name),\(date),\(weight),\(repetitions),\(sets)\n"
            csvText.append(newLine)
        }
        
        do {
            try csvText.write(to: path, atomically: true, encoding: .utf8)
            print("CSV file created at: \(path)")
            // You might want to add an alert or other UI feedback to inform the user that the export is successful
        } catch {
            print("Failed to create CSV file: \(error.localizedDescription)")
            // You might want to add an alert or other UI feedback to inform the user about the failure
        }
    }
    
    func formatDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}

struct ExportDataSheet_Previews: PreviewProvider {
    static var previews: some View {
        ExportDataSheet()
    }
}
