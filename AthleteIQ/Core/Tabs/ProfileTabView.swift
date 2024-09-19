//
//  ProfileTabView.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/25/24.
//

import SwiftUI
import SwiftData

struct ProfileTabView: View {
    @State private var isShowingItemSheet = false
    @State private var isShowingExportDataSheet = false
    @Environment(\.modelContext) var context
    @Query(sort: \Exercise.date)
    var exercises: [Exercise]
    
    var totalSets: Int {
        exercises.reduce(0) { $0 + $1.sets }
    }
    
    var totalReps: Int {
        exercises.reduce(0) { $0 + ($1.sets * $1.repetitions) }
    }
    
    var body: some View {
        NavigationView{
            List{
                Section(header:
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
                ) {
                }
                Section(header:
                            Text("Goals").font(.headline)
                ) {
                    NavigationLink(destination: GoalsView()) {
                        Text("View/Edit My Goals")
                            .font(.body)
                            .bold()
                    }
                    
                }
                
                Section("Statistics") {
                    VStack {
                        InfoRow(title: "Total Exercises Entered:", value: "\(exercises.count)")
                        InfoRow(title: "Total Sets Performed:", value: "\(totalSets)")
                        InfoRow(title: "Total Repetitions Performed:", value: "\(totalReps)")
                        InfoRow(title: "Total Minutes of Cardio:", value: "1000 min")
                    }
                }
                
                Section("Export Data") {
                    VStack {
                        
                        ShareLink(item:generateCSV(exercises: exercises)!) {
                            Label("Export CSV", systemImage: "list.bullet.rectangle.portrait")
                        }
                        
                    }
                    .padding()
                }
                
                
                Section("Help"){
                    Button(action: {
                        //              Open helpsheetview
                        isShowingItemSheet = true
                    }) {
                        HStack{
                            Text("App Instructions")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                    }
                    
                    
                }
            }
            
            
        }
        .sheet(isPresented: $isShowingItemSheet) {
            HelpSheet()
        }
        .sheet(isPresented: $isShowingExportDataSheet) {
            ExportDataSheet()
        }
        
        
    }
    
    struct GoalsView: View {
        @Environment(\.modelContext) private var context
        @Query(sort: \Goals.workoutsPerWeek)
        var goals: [Goals]
        
        @State private var workoutsPerWeek: String = ""
        @State private var minutesOfCardioPerWeek: String = ""
        @State private var dailyCaloricIntake: String = ""
        @State private var dailyHoursOfSleep: String = ""
        @State private var goalWeight: String = ""
        @State private var showingAlert = false
        @State private var alertMessage = ""
        
        @Environment(\.presentationMode) var presentationMode // Add this line

        var body: some View {
            Form {
                Section(header: Text("Set Your Goals").font(.headline)) {
                    goalInput(label: "Workouts per week (1-7)", text: $workoutsPerWeek)
                    goalInput(label: "Minutes of cardio per week", text: $minutesOfCardioPerWeek)
                    goalInput(label: "Daily caloric intake (kcal)", text: $dailyCaloricIntake)
                    goalInput(label: "Daily hours of sleep", text: $dailyHoursOfSleep)
                    goalInput(label: "Goal weight (lbs)", text: $goalWeight)
                }
                
                Section {
                    Button(action: saveGoals) {
                        Text("Save Goals")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .navigationTitle("Update Goals")
            .onAppear(perform: loadGoals)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Invalid Input"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }

        private func goalInput(label: String, text: Binding<String>) -> some View {
            HStack {
                Text(label)
                    .font(.body)
                    .frame(width: 200, alignment: .leading)
                TextField("", text: text)
                    .keyboardType(label.contains("hours") ? .decimalPad : .numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            .padding(.vertical, 4)
        }

        private func saveGoals() {
            guard let workouts = Int(workoutsPerWeek),
                  let cardio = Int(minutesOfCardioPerWeek),
                  let calories = Int(dailyCaloricIntake),
                  let sleep = Int(dailyHoursOfSleep),
                  let weight = Int(goalWeight) else {
                alertMessage = "Please enter valid integer values for all goals."
                showingAlert = true
                return
            }

            if let existingGoals = goals.first {
                existingGoals.workoutsPerWeek = workouts
                existingGoals.cardioPerWeek = cardio
                existingGoals.calorieIntake = calories
                existingGoals.hoursOfSleep = sleep
                existingGoals.weight = weight
                
                do {
                    try context.save()
                    print("Goals updated.")
                    presentationMode.wrappedValue.dismiss() // Dismiss the view after saving
                } catch {
                    alertMessage = "Failed to update goals: \(error.localizedDescription)"
                    showingAlert = true
                }
            } else {
                let newGoals = Goals(workoutsPerWeek: workouts, cardioPerWeek: cardio, calorieIntake: calories, hoursOfSleep: sleep, weight: weight)
                
                context.insert(newGoals)
                do {
                    try context.save()
                    print("Goals saved.")
                    presentationMode.wrappedValue.dismiss() // Dismiss the view after saving
                } catch {
                    alertMessage = "Failed to save goals: \(error.localizedDescription)"
                    showingAlert = true
                }
            }
        }

        private func loadGoals() {
            if let existingGoals = goals.first {
                workoutsPerWeek = String(existingGoals.workoutsPerWeek)
                minutesOfCardioPerWeek = String(existingGoals.cardioPerWeek)
                dailyCaloricIntake = String(existingGoals.calorieIntake)
                dailyHoursOfSleep = String(existingGoals.hoursOfSleep)
                goalWeight = String(existingGoals.weight)
            }
        }
    }


    
}
struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.primary)
                .font(.headline)
            Spacer()
            Text(value)
        }
        .padding()
        .background(Color.blue.opacity(0.3))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

func generateCSV(exercises: [Exercise]) -> URL? {
    var fileURL: URL?
    
    // heading of CSV file.
    let heading = "Name, Date, Weight, Repetitions, Sets\n"
    
    // file rows
    let rows = exercises.map { "\(cleanCSVString($0.name)), \($0.date), \($0.weight), \($0.repetitions), \($0.sets)" }
    
    // rows to string data
    let stringData = heading + rows.joined(separator: "\n")
    
    do {
        let path = try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        
        fileURL = path.appendingPathComponent("Exercise-Data.csv")
        
        // append string data to file
        try stringData.write(to: fileURL!, atomically: true, encoding: .utf8)
        print("CSV file created at: \(fileURL!.path)")
        
    } catch {
        print("Error generating CSV file: \(error)")
    }
    
    return fileURL
}

func cleanCSVString(_ string: String) -> String {
    var cleanedString = string.replacingOccurrences(of: ",", with: "")
    cleanedString = cleanedString.replacingOccurrences(of: "\n", with: " ")
    return cleanedString
}


