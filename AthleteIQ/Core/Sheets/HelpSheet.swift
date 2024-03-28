import SwiftUI

struct HelpSheet: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
                }
                .padding()
            }
            
            Text("Welcome to AthleteIQ!")
                .font(.title)
                .padding(.bottom, 10)
            
            Text("How to Use the App:")
                .font(.headline)
                .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("1. Log Your Exercises:")
                Text("   - Tap on the '+' button to add a new exercise.")
                Text("   - Enter the details like name, sets, reps, and weight.")
                Text("   - Your exercise will be added to your history.")
                    .padding(.bottom, 10)
                
                Text("2. View Progress:")
                Text("   - Check out your progress on the 'Home' tab.")
                Text("   - The app generates estimated one-rep maxes for your exercises.")
                Text("   - You can see your progress graphically when you tap on an exercise.")
                    .padding(.bottom, 10)
                
                Text("3. Edit or Delete Exercises:")
                Text("   - Check out your history on the 'History' tab.")
                Text("   - Swipe left on an exercise to delete.")
                Text("   - Tap on an exercise to edit.")
                    .padding(.bottom, 10)
                
                Text("4. Share Your Progress:")
                Text("   - Save your exercises to a csv file in the 'More' tab.")
                Text("   - Share with your friends!")
                    .padding(.bottom, 10)
                
                Text("5. Stay Motivated:")
                Text("   - Use the app to track your progress over time.")
                Text("   - Watch your estimated one-rep maxes improve as you get stronger!")
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
    }
}

struct HelpSheet_Previews: PreviewProvider {
    static var previews: some View {
        HelpSheet()
    }
}
