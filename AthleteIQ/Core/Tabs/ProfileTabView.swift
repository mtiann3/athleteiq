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
                    // Placeholder for any additional header content
                }
                
                Section("General") {
                    VStack {
                        InfoRow(title: "Total Exercises Entered:", value: "\(exercises.count)")
                        InfoRow(title: "Total Sets Performed:", value: "\(totalSets)")
                        InfoRow(title: "Total Repetitions Performed:", value: "\(totalReps)")
                    }
                }
                
                Section("Export Data") {
                    Button(action: {
                        isShowingExportDataSheet.toggle()
                    }) {
                        Label("Export CSV", systemImage: "list.bullet.rectangle.portrait")
                    }
                }
                
                Section("Help") {
                    Button(action: {
                        isShowingItemSheet.toggle()
                    }) {
                        HStack{
                            Text("App Instructions")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            
            .sheet(isPresented: $isShowingItemSheet) {
                HelpSheet()
            }
            .sheet(isPresented: $isShowingExportDataSheet) {
                ExportDataSheet()
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

struct ProfileTabView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileTabView()
    }
}
