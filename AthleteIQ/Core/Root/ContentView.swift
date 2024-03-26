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
            EditExerciseTabView()
                .tabItem {
                    Label("Edit", systemImage: "square.and.pencil.circle.fill")
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

