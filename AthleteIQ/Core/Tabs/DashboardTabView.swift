import SwiftUI
import SwiftData

struct DashboardTabView: View {
    @Environment(\.modelContext) var context
    @Query(sort: \Exercise.date)
    var exercises: [Exercise]
    @State private var selectedExercise: Exercise?
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        NavigationView {
            List  {
                VStack(alignment: .leading, spacing: 4) {
                    Text("ProgressPro")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .textCase(nil)
                    Text("Your Personal Fitness Assistant")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 12)

                Section(header: Text("Today's Progress").bold().font(.title2)) {
                    LazyVGrid(columns: gridItems, spacing: 30) {
                        // Wrapping each CirclePercentageChart with a ZStack and a RoundedRectangle
                       
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 2)
                            CirclePercentageChart(percentage: 50, color: .blue, title: "Sleep", destination: ProfileTabView())
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 2)
                            CirclePercentageChart(percentage: 30, color: .green, title: "Nutrition", destination: ProfileTabView())
                        }
                       
                    }
                    .padding()
                }
                .listRowBackground(Color.clear)
                Section(header: Text("This Week's Progress").bold().font(.title2)) {
                    LazyVGrid(columns: gridItems, spacing: 30) {
                        // Wrapping each CirclePercentageChart with a ZStack and a RoundedRectangle
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 2)
                            CirclePercentageChart(percentage: 75, color: .red, title: "Lifts", destination: ProfileTabView())
                        }
                        
                       
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 2)
                            CirclePercentageChart(percentage: 90, color: .orange, title: "Cardio", destination: ProfileTabView())
                        }
                    }
                    .padding()
                }
                .listRowBackground(Color.clear)


            }
          
            
        }
    }
    struct DetailView: View {
        @Environment(\.modelContext) var context
        @State private var isShowingItemSheet = false
        @Query(sort: \Exercise.date)
        var exercises: [Exercise]
        @State private var selectedExercise: Exercise?
        
        var body: some View {
            NavigationView{
                
                
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
                Text("Hello, I'm a Detail View")
                
            }
            .sheet(item: $selectedExercise) { exercise in
                ViewExerciseProgressSheet(exerciseName: exercise.name)
            }
        }
        
        
    }
}
