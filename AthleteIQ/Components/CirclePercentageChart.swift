import SwiftUI

struct CirclePercentageChart<Destination: View>: View {
    var percentage: Double
    var color: Color
    var title: String
    var destination: Destination

    var body: some View {
//        NavigationLink(destination: destination) {
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 20)
                Circle()
                    .trim(from: 0.0, to: percentage / 100)
                    .stroke(color, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text(title)
                    .bold()
            }
            .padding()
//        }
        
        .buttonStyle(PlainButtonStyle()) // Optional: to remove default button styling
    }
}
