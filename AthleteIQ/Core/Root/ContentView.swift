//
//  ContentView.swift
//  SwiftDataExample
//
//  Created by Mike Iannotti on 3/24/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var body: some View {
        TabView{
            DashboardTabView()
                .tabItem {
                    Label("Dashboard", systemImage: "house.fill")
            }
            TrainingTabView()
                .tabItem {
                    Label("Training", systemImage: "figure.strengthtraining.traditional")
            }
            WellnessTabView()
                .tabItem {
                    Label("Wellness", systemImage: "heart.text.square.fill")
            }
            EditExerciseTabView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            ProfileTabView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
            }
        }
    }
}

#Preview {
    ContentView()
}

