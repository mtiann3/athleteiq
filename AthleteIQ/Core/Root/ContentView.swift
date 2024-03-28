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
                    Label("Home", systemImage: "house.fill")
            }
            EditExerciseTabView()
                .tabItem {
                    Label("History", systemImage: "clock")
                }
            ProfileTabView()
                .tabItem {
                    Label("More", systemImage: "ellipsis")
            }
        }
    }
}

#Preview {
    ContentView()
}

