import SwiftUI
import SwiftData

struct TrainingTabView: View {
    @State private var isShowingLiftSheet = false
    @State private var isShowingCardioSheet = false
    
    @Environment(\.modelContext) var context
    @Query(sort: \Exercise.date) var lifts: [Exercise]
    @Query(sort: \Cardio.date) var cardioExercises: [Cardio]

    var weeklyLifts: [Exercise] {
        lifts.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) || $0.date >= Calendar.current.date(byAdding: .day, value: -7, to: Date())! }
    }

    var weeklyCardio: [Cardio] {
        cardioExercises.filter { Calendar.current.isDate($0.date, inSameDayAs: Date()) || $0.date >= Calendar.current.date(byAdding: .day, value: -7, to: Date())! }
    }

    var totalSets: Int {
        weeklyLifts.reduce(0) { $0 + $1.sets }
    }

    var totalReps: Int {
        weeklyLifts.reduce(0) { $0 + $1.repetitions }
    }

    var totalCardioDuration: Double {
        weeklyCardio.reduce(0) { $0 + $1.time }
    }

    var body: some View {
        NavigationView {
            List {
                // Weight Exercises Section
                Section(header: Text("Weight Exercises").font(.headline)) {
                    if weeklyLifts.isEmpty {
                        Text("No weight exercises logged this week.")
                    } else {
                        VStack(alignment: .leading) {
                            Text("Total Exercises: \(weeklyLifts.count)")
                            Text("Total Sets: \(totalSets)")
                            Text("Total Repetitions: \(totalReps)")
                        }
                        .font(.headline)
                        .padding()
                        
//                        ForEach(weeklyLifts, id: \.self) { lift in
//                            VStack(alignment: .leading) {
//                                Text(lift.name)
//                                    .font(.headline)
//                                Text("Sets: \(lift.sets), Reps: \(lift.repetitions)")
//                                    .font(.subheadline)
//                                    .foregroundColor(.gray)
//                            }
//                            .padding(.vertical, 4)
//                        }
//                        .onDelete(perform: deleteLifts)
                    }
                }
                Section{
                    NavigationLink(destination: LiftsListView(lifts: lifts)) {
                        Text("View Exercises")
                            .font(.body)
                            .bold()
                    }
                }

                // Cardio Exercises Section
                Section(header: Text("Cardio Exercises").font(.headline)) {
                    if weeklyCardio.isEmpty {
                        Text("No cardio exercises logged this week.")
                    } else {
                        VStack(alignment: .leading) {
                            Text("Total Cardio Sessions: \(weeklyCardio.count)")
                            Text("Total Duration: \(totalCardioDuration, specifier: "%.1f") minutes")
                        }
                        .font(.headline)
                        .padding()

                        ForEach(weeklyCardio, id: \.self) { cardio in
                            VStack(alignment: .leading) {
                                Text(cardio.date, formatter: dateFormatter)
                                    .font(.headline)
                                Text("Duration: \(cardio.time, specifier: "%.1f") min")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteCardio)
                    }
                }
            }
            .navigationTitle("Training")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingLiftSheet = true
                    }) {
                        Text("Add Lift")
                            .bold()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingCardioSheet = true
                    }) {
                        Text("Add Cardio")
                            .bold()
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingLiftSheet) {
            AddExerciseSheet()
        }
        .sheet(isPresented: $isShowingCardioSheet) {
            AddCardioSheet()
        }
    }
    
    private func deleteLifts(at offsets: IndexSet) {
        for index in offsets {
            let liftToDelete = lifts[index]
            context.delete(liftToDelete)
        }
        do {
            try context.save()
        } catch {
            print("Error deleting lift: \(error.localizedDescription)")
        }
    }
    
    private func deleteCardio(at offsets: IndexSet) {
        for index in offsets {
            let cardioToDelete = cardioExercises[index]
            context.delete(cardioToDelete)
        }
        do {
            try context.save()
        } catch {
            print("Error deleting cardio: \(error.localizedDescription)")
        }
    }
}

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()


struct LiftsListView: View {
    var lifts: [Exercise]

    var body: some View {
        NavigationView {
            List {
                let uniqueLifts = Set(lifts.map { $0.name }) // Get unique lift names

                if uniqueLifts.isEmpty {
                    Text("No lifts logged.")
                } else {
                    ForEach(Array(uniqueLifts), id: \.self) { liftName in
                        NavigationLink(destination: LiftDetailView(liftName: liftName, allLifts: lifts)) {
                            Text(liftName)
                                .font(.headline)
                        }
                    }
                }
            }
            .navigationTitle("All Lifts")
        }
    }
}

struct LiftDetailView: View {
    var liftName: String
    var allLifts: [Exercise]

    @State private var oneRepMaxArr: [Double] = []
    @State private var datesArr: [Date] = []
    @Environment(\.modelContext) var context
    @State private var isDataUpdated = false // Track if data is updated

    var body: some View {
        VStack {
            Text("\(liftName) Progress")
                .font(.title)
                .bold()
                .padding()

            if !oneRepMaxArr.isEmpty && !datesArr.isEmpty {
                LineChart(data: oneRepMaxArr, title: "\(liftName) One Rep Max Progress")
                    .padding(.bottom, 20)
            } else {
                Text("No data available for chart.")
                    .padding(.bottom, 20)
            }

            List {
                let filteredLifts = allLifts.filter { $0.name == liftName }

                if filteredLifts.isEmpty {
                    Text("No entries for this lift.")
                } else {
                    ForEach(filteredLifts.sorted(by: { $0.date < $1.date }), id: \.id) { lift in
                        ExerciseDetailView(exercise: lift)
                    }
                    .onDelete(perform: deleteLifts)
                }
            }
        }
        .onAppear {
            calculateOneRepMaxValues()
        }
        .onChange(of: isDataUpdated) { _ in
            calculateOneRepMaxValues() // Recalculate when data is updated
        }
        .navigationTitle(liftName)
    }

    private func calculateOneRepMaxValues() {
        oneRepMaxArr.removeAll()
        datesArr.removeAll()

        for lift in allLifts.filter({ $0.name == liftName }) {
            let estimated1RM = calculateEstimated1RM(exercise: lift)
            if estimated1RM > 0 { // Only add valid values
                oneRepMaxArr.append(estimated1RM)
                datesArr.append(lift.date)
            }
        }
    }

    func calculateEstimated1RM(exercise: Exercise) -> Double {
        let reps = Double(exercise.repetitions)
        guard reps > 0 else { return 0 } // Avoid division by zero
        let oneRepMax = exercise.weight * (1 + reps / 30.0)
        return (oneRepMax.isNaN || oneRepMax.isInfinite) ? 0 : oneRepMax // Return 0 if invalid
    }

    private func deleteLifts(at offsets: IndexSet) {
        let filteredLifts = allLifts.filter { $0.name == liftName }
        for index in offsets {
            let liftToDelete = filteredLifts[index]
            context.delete(liftToDelete)
        }
        do {
            try context.save()
            isDataUpdated.toggle() // Trigger a data refresh
        } catch {
            print("Error deleting lift: \(error.localizedDescription)")
        }
    }
}
