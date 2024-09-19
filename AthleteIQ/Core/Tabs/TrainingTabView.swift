//
//  TrainingTabView.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 9/19/24.
//

import SwiftUI

struct TrainingTabView: View {
    @State private var isShowingLiftSheet = false
    @State private var isShowingCardioSheet = false

    var body: some View {
        NavigationView{
            List{
                Section{
                    Text("Weight Exercises")
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isShowingLiftSheet = true
                        }) {
                            Text("Add Lift")
                                .bold()
                        }
                    }
                }
                Section{
                    Text("Cardio Exercises")
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isShowingCardioSheet = true
                        }) {
                            Text("Add Cardio")
                                .bold()
                        }
                    }
                }
            }
            
            
            
        }
        .sheet(isPresented: $isShowingLiftSheet) {
            AddExerciseSheet()
        }
        .sheet(isPresented: $isShowingCardioSheet) {
            AddCardioSheet()
        }
    }
}

#Preview {
    TrainingTabView()
}
