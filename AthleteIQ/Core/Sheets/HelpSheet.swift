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
            
            Text("About AthleteIQ:")
                .font(.headline)
                .padding(.bottom, 5)
            
            Text("AthleteIQ is your all-in-one fitness companion designed to help you track your workouts, monitor your progress, and achieve your fitness goals. Whether you’re lifting weights, doing cardio, or keeping an eye on your nutrition and sleep, AthleteIQ has you covered.")
                .padding(.bottom, 10)
            
            Text("How to Use the App:")
                .font(.headline)
                .padding(.bottom, 5)
            
            VStack(alignment: .leading, spacing: 8) {
                Text("1. Log Your Exercises:")
                Text("   - Use the 'Training' tab to log your weight lifts and cardio.")
                Text("   - Tap on the 'add' button to add a new exercise.")
                Text("   - Enter the details.")
                Text("   - Your exercise will be added to your history.")
                    .padding(.bottom, 10)
                
                Text("2. Track Cardio and Nutrition:")
                Text("   - Use the 'Wellness' tab to log your cardio activities, meals, and sleep data.")
                Text("   - Monitor your caloric intake and macronutrient balance.")
                    .padding(.bottom, 10)
                
                Text("3. View Progress:")
                Text("   - Check out a specific weightlifting progress by selecting 'View Exercises.")
                Text("   - The app generates estimated one-rep maxes for your exercises.")
                Text("   - Visualize your improvements through charts and statistics.")
                    .padding(.bottom, 10)
                
                Text("4. Edit or Delete Entries:")
                Text("   - Access your weightlifting history on the 'History' tab.")
                Text("   - Swipe left on an entry to delete.")
                Text("   - Tap on an entry to edit.")
                    .padding(.bottom, 10)
                
                Text("5. Export Your Data:")
                Text("   - Save your workouts, cardio, nutrition, and sleep data to a CSV file.")
                Text("   - Easily share your progress with friends or coaches.")
                    .padding(.bottom, 10)
                
                Text("6. Stay Motivated:")
                Text("   - Use the app to track your progress over time.")
                Text("   - Set fitness goals and work towards achieving them!")
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
