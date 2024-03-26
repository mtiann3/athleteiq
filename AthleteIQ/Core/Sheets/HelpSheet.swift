//
//  HelpSheet.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/26/24.
//

import SwiftUI

struct HelpSheet: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Close")
//                            .font(.title)
//                            .foregroundColor(.blue)
                }
                .padding()
            }
            Text("App Instructions:")
            Spacer()
        }
    }
}

struct HelpSheet_Previews: PreviewProvider {
    static var previews: some View {
        HelpSheet()
    }
}
