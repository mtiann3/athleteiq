import SwiftUI
import SwiftData

struct DashboardTabView: View {
    @Environment(\.modelContext) var context
    @State private var isShowingItemSheet = false
    @Query(sort: \Expense.date)
    var expenses: [Expense]
    @State private var selectedExpense: Expense?

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
                    let uniqueExpenseNames = Set(expenses.map { $0.name })
                    
                    ForEach(uniqueExpenseNames.sorted(), id: \.self) { name in
                        let filteredExpenses = expenses.filter { $0.name == name }
                        if let expense = filteredExpenses.sorted(by: { $0.date > $1.date }).first {
                            ExpenseCell(expense: expense)
                                .onTapGesture {
                                    self.selectedExpense = expense
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
                if expenses.isEmpty {
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
            AddExpenseSheet()
        }
        .sheet(item: $selectedExpense) { expense in
            ViewExerciseProgressSheet(expense: expense)
        }
    }
}
