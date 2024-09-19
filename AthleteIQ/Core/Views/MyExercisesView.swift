//
//  MyExercisesView.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 9/19/24.
//

import SwiftUI

struct FirstColumnView: View {
    var body: some View {
        List {
            Text("First Column")  
            NavigationLink("Open Next View") {
            }
        }
 .navigationTitle("First Navigation Title")
 }
}
