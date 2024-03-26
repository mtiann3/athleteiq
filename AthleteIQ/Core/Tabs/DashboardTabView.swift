import SwiftUI
import SwiftData

struct DashboardTabView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @Query(sort: \Exercise.date)
    var exercises: [Exercise]
    @State private var selectedExercise: Exercise?

    var body: some View {
        NavigationView {
            List {
                Section(header:
                            VStack(alignment: .leading, spacing: 4) {
                                Text("AthleteIQ")
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                Text("Your Personal Fitness Assistant")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 12)
                ) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Current Login Streak:")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                        }
                        Spacer()
                        Text("25")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 72)
                            .background(Color(.systemGreen))
                            .clipShape(Circle())
                    }
                }
                
                Section(header: Text("My Exercises")) {
                    let uniqueExerciseNames = Set(exercises.map { $0.name })
                    
                    ForEach(uniqueExerciseNames.sorted(), id: \.self) { name in
                        let filteredExercises = exercises.filter { $0.name == name }
                        if let exercise = filteredExercises.sorted(by: { $0.date > $1.date }).first {
                            ExerciseCell(exercise: exercise)
                                .onTapGesture {
                                    self.selectedExercise = exercise
                                }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingItemSheet = true
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .overlay {
                if exercises.isEmpty {
                    VStack {
                        Spacer()
                        ContentUnavailableView(label: {
                            Label("No Exercises", systemImage: "dumbbell.fill")
                        }, description: {
                            Text("Start adding exercises to see your progress.")
                        }, actions: {
                            Button("Add Exercise") {
                                isShowingItemSheet = true
                            }
                        })
                        .padding()
                        Spacer()
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingItemSheet) {
            AddExerciseSheet()
        }
        .sheet(item: $selectedExercise) { exercise in
            ViewExerciseProgressSheet(exercise: exercise)
        }
    }
}
