//
//  ContentView.swift
//  Event Cooldown
//
//  Created by Masoud Toorani on 28.10.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var currentDate = Date() // Track current time for countdown
    private let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect() // Timer to update every second
    
    var body: some View {
        EventsView(currentDate: currentDate) // Passing currentDate to EventsView
                    .onReceive(timer) { _ in
                        currentDate = Date() // Update the current date every second for all rows
                    }
    }
}

#Preview {
    ContentView()
}
