//
//  ProfileTabView.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/25/24.
//

import SwiftUI
import SwiftData

struct ProfileTabView: View {
    @State private var isShowingItemSheet = false

    
    var body: some View {
        List{
            Section {
                HStack {
                    Text("U")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 72, height: 72)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text("Username")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .padding(.top, 4)
                        //                                Text(user.email)
                        //                                    .font(.footnote)
                        //                                    .foregroundColor(.gray)
                        //                        if the text is a string, switch foregroundcolor to accent color.
                    }
                    Spacer()
                    
                }
                
            }
            
            Section("General") {
                
                
            }
            
            Section("Profile") {
                
                
                
            }
            
            Section("Account") {
                
                
            }
            Section{
                Button(action: {
//              Open helpsheetview
                    isShowingItemSheet = true
                }) {
                    Text("App instructions")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .bold()
                }
            
               
            }
                
            
        }
        .sheet(isPresented: $isShowingItemSheet) {
            HelpSheet()
        }
        
    }
    
}

#Preview {
    ProfileTabView()
}
