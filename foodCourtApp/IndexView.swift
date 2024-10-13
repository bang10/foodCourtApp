//
//  ContentView.swift
//  foodCourtApp
//
//  Created by bangseonghwan on 10/11/24.
//

import SwiftUI

struct IndexView: View {
    @Binding var userId: String
    
    init(userId: Binding<String> = .constant("")) {
        _userId = userId
    }
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    IndexView()
}
