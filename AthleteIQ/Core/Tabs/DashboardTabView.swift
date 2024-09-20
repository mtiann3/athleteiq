import SwiftUI
import SwiftData

struct DashboardTabView: View {
    //------------QUERY-----------------------------------------------------------------------------
    
    @Environment(\.modelContext) var context
    @Query(sort: \Exercise.date)
    var exercises: [Exercise]
    
    @Query(sort: \Goals.workoutsPerWeek)
    var goals: [Goals]
    
    @Query(sort: \Cardio.date) // Query for Cardio
    var cardioRecords: [Cardio]
    
    @Query(sort: \Food.date) // Query for Food
    var foodRecords: [Food]
    
    @Query(sort: \Sleep.date)
    var sleepRecords: [Sleep] // Query for Sleep records
    
    //-----------DATES--------------------------------------------------------------------------------
    // Get today's date
    var today: Date {
        Calendar.current.startOfDay(for: Date())
    }
    
    // Get the start of the current week
    var startOfWeek: Date {
        let calendar = Calendar.current
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
    //------------TOTAL COUNTS-----------------------------------------------------------------------
    
    
    // Count unique days with at least one exercise recorded this week
    var exerciseCount: Int {
        let uniqueDays = Set(
            exercises
                .filter { $0.date >= startOfWeek && $0.date < today.addingTimeInterval(86400) } // Include today
                .map { Calendar.current.startOfDay(for: $0.date) }
        )
        return uniqueDays.count
    }
    // Total cardio minutes logged this week
    var totalCardio: Double {
        cardioRecords
            .filter { $0.date >= startOfWeek && $0.date < today.addingTimeInterval(86400) }
            .map { $0.time } // Sum the time from the Cardio model
            .reduce(0, +)
    }
    
    // Total calories consumed today
    var totalCalories: Int {
        foodRecords
            .filter { Calendar.current.isDate($0.date, inSameDayAs: today) } // Filter for today's food records
            .map { ($0.carbs * 4) + ($0.fat * 9) + ($0.protein * 4) } // Corrected parenthesis
            .reduce(0, +)
    }
    
    // Total sleep time today
    var totalSleep: Double {
        sleepRecords
            .filter { Calendar.current.isDate($0.date, inSameDayAs: today) } // Filter for today's sleep records
            .map { $0.time }
            .reduce(0, +)
    }
    
    //------------GOALS-----------------------------------------------------------------------------
    
    // Get the workouts per week goal
    var goalExerciseCount: Int {
        goals.first?.workoutsPerWeek ?? 0
    }
    
    
    // Get the cardio per week goal
    var goalCardioCount: Int {
        goals.first?.cardioPerWeek ?? 0 // Adjust if needed to match your model
    }
    
    // Get the calorie intake goal
    var goalCalorieIntake: Int {
        goals.first?.calorieIntake ?? 0
    }
    // Get the sleep goal
    var goalSleepHours: Double {
        Double(goals.first?.hoursOfSleep ?? 0)
    }
    //----------------------------------------------------------------------------------------------
    let gridItems = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        NavigationView {
            List  {
                VStack(alignment: .leading, spacing: 4) {
                    Text("AthleteIQ")
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
                            CirclePercentageChart(
                                percentage: goalSleepHours > 0 ? (totalSleep / goalSleepHours) * 100 : 0,
                                color: .purple,
                                title: "Sleep",
                                destination: ProfileTabView()
                            )
                        }
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 2)
                            CirclePercentageChart(
                                percentage: goalCalorieIntake > 0 ? Double(totalCalories) / Double(goalCalorieIntake) * 100 : 0,
                                color: .green,
                                title: "Nutrition",
                                destination: ProfileTabView()
                            )
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
                            CirclePercentageChart(
                                percentage: goalExerciseCount > 0 ? Double(exerciseCount) / Double(goalExerciseCount) * 100 : 0,
                                color: .red,
                                title: "Lifts",
                                destination: ProfileTabView()
                            )
                            
                        }
                        
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 2)
                            CirclePercentageChart(
                                percentage: goalCardioCount > 0 ? (40 / Double(goalCardioCount)) * 100 : 0,
                                color: .orange,
                                title: "Cardio",
                                destination: ProfileTabView()
                            )
                        }
                    }
                    .padding()
                }
                .listRowBackground(Color.clear)
                
                
            }
            
            
        }
    }
    
}
