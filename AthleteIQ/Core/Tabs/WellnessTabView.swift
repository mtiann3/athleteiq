import SwiftUI
import SwiftData

struct WellnessTabView: View {
    @State private var isShowingNutritionSheet = false
    @State private var isShowingSleepSheet = false
    
    @Environment(\.modelContext) var context // Access the SwiftData context
    @Query(sort: \Food.date) var foods: [Food] // Fetch food data, sorted by date
    @Query(sort: \Sleep.date) var sleepData: [Sleep] // Fetch sleep data, sorted by date
    
    var foodsForToday: [Food] {
        foods.filter { Calendar.current.isDateInToday($0.date) }
    }
    
    var totalCarbs: Int {
        foodsForToday.reduce(0) { $0 + $1.carbs }
    }
    
    var totalFat: Int {
        foodsForToday.reduce(0) { $0 + $1.fat }
    }
    
    var totalProtein: Int {
        foodsForToday.reduce(0) { $0 + $1.protein }
    }
    
    var totalCalories: Int {
        return (totalCarbs * 4) + (totalProtein * 4) + (totalFat * 9)
    }
    
    var sleepForToday: [Sleep] {
        sleepData.filter { Calendar.current.isDateInToday($0.date) }
    }
    
    var totalSleep: Double {
        sleepForToday.reduce(0) { $0 + $1.time }
    }
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Nutrition").font(.headline)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Total Calories: \(totalCalories) kcal")
                            .font(.headline)
                        HStack {
                            Text("Carbs: \(totalCarbs)g")
                            Spacer()
                            Text("Fats: \(totalFat)g")
                            Spacer()
                            Text("Protein: \(totalProtein)g")
                        }
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)
                    Spacer()
                    if foodsForToday.isEmpty {
                        Text("No food logged for today.")
                    } else {
                        ForEach(foodsForToday, id: \.self) { food in
                            VStack(alignment: .leading) {
                                Text(food.name)
                                    .font(.headline)
                                HStack {
                                    Text("Carbs: \(food.carbs)g")
                                    Spacer()
                                    Text("Fats: \(food.fat)g")
                                    Spacer()
                                    Text("Protein: \(food.protein)g")
                                }
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteFood) // Enable swipe-to-delete
                    }
                }
                
                Section(header: Text("Sleep").font(.headline)) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Total Sleep: \(totalSleep, specifier: "%.2f") hours")
                            .font(.headline)
                    }
                    .padding(.vertical, 8)
                    
                    if sleepForToday.isEmpty {
                        Text("No sleep data logged for today.")
                    } else {
                        ForEach(sleepForToday, id: \.self) { sleep in
                            VStack(alignment: .leading) {
                                Text("Sleep Duration: \(sleep.time, specifier: "%.2f") hours")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteSleep) // Enable swipe-to-delete
                    }
                }
            }
            .navigationTitle("Wellness")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingNutritionSheet = true
                    }) {
                        Text("Add Food")
                            .bold()
                    }
                    
                    Button(action: {
                        isShowingSleepSheet = true
                    }) {
                        Text("Add Sleep")
                            .bold()
                    }
                }
            }
        }
        .sheet(isPresented: $isShowingNutritionSheet) {
            AddFoodSheet()
        }
        .sheet(isPresented: $isShowingSleepSheet) {
            AddSleepSheet()
        }
    }
    
    private func deleteFood(at offsets: IndexSet) {
        for index in offsets {
            let foodToDelete = foodsForToday[index]
            context.delete(foodToDelete)
        }
        do {
            try context.save()
        } catch {
            print("Error deleting food: \(error.localizedDescription)")
        }
    }
    
    private func deleteSleep(at offsets: IndexSet) {
        for index in offsets {
            let sleepToDelete = sleepForToday[index]
            context.delete(sleepToDelete)
        }
        do {
            try context.save()
        } catch {
            print("Error deleting sleep: \(error.localizedDescription)")
        }
    }
}
