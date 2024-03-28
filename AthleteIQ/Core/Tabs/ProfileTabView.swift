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
        List{
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
            }

            Section("General") {
                               VStack {
                                   InfoRow(title: "Total Exercises Entered:", value: "\(exercises.count)")
                                   InfoRow(title: "Total Sets Performed:", value: "\(totalSets)")
                                   InfoRow(title: "Total Repetitions Performed:", value: "\(totalReps)")
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
        .sheet(isPresented: $isShowingItemSheet) {
            HelpSheet()
        }
        .sheet(isPresented: $isShowingExportDataSheet) {
            ExportDataSheet()
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



#Preview {
    ProfileTabView()
}
