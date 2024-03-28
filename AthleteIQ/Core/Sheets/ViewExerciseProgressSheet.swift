import SwiftUI
import SwiftData

struct ViewExerciseProgressSheet: View {
    let exerciseName: String
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) var context
    
    @Query(sort: \Exercise.date)
    var exercises: [Exercise]
    
    @State private var oneRepMaxArr: [Double] = []
    @State private var datesArr: [Date] = []
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                        .padding()
                }
            }
            
            Text("\(exerciseName) Progress")
                .font(.title)
                .bold()
                .padding(.bottom, 20)
            
            if !oneRepMaxArr.isEmpty && !datesArr.isEmpty {
                LineChart(data: oneRepMaxArr, title: "\(exerciseName) Progress")
                    .padding(.bottom, 20)
            }
            Text("History")
                .font(.title2)
                .bold()
            List {
                ForEach(exercises.filter { $0.name == exerciseName }.reversed(), id: \.self) { exercise in
                    Section {
                        ExerciseDetailView(exercise: exercise)
                    }
                }
            }
            
        }
        .padding()
        .onAppear {
            for exercise in exercises.filter({ $0.name == exerciseName }) {
                oneRepMaxArr.append(calculateEstimated1RM(exercise: exercise))
                datesArr.append(exercise.date)
            }
        }
    }
    
    func calculateEstimated1RM(exercise: Exercise) -> Double {
        let reps = Double(exercise.repetitions)
        if (reps == 1){
            return exercise.weight
        }
        let oneRepMax = exercise.weight * (1 + reps / 30.0)
        return oneRepMax
    }
}

struct ExerciseDetailView: View {
    let exercise: Exercise
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Name:")
                    .bold()
                Spacer()
                Text(exercise.name)
            }
            HStack {
                Text("Weight:")
                    .bold()
                Spacer()
                
                Text("\(Int(exercise.weight)) lbs")
            }
            HStack {
                Text("Reps:")
                    .bold()
                    Spacer()
                Text("\(exercise.repetitions)")
            }
            HStack {
                Text("Sets:")
                    .bold()
                    Spacer()
                Text("\(exercise.sets)")
            }
            HStack {
                Text("Date:")
                    .bold()
                    Spacer()
                Text(formattedDate(exercise.date))
            }
        }
        .padding(8) // Add padding around the VStack
        .background(Color.white) // Optional: Add background color
        .cornerRadius(8) // Optional: Add corner radius for rounded corners
        .shadow(radius: 3) // Optional: Add shadow for depth effect
        .preferredColorScheme(.light) // Set the preferred color scheme to light mode
    }
    
    func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Adjust the format as needed
        return dateFormatter.string(from: date)
    }
}
