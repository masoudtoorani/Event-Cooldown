//
//  EventRow.swift
//  Event Cooldown
//
//  Created by Masoud Toorani on 3.11.2024.
//

import SwiftUI

struct EventRow: View {
    var event: Event
    var currentDate: Date
        
    var body: some View {
        VStack (alignment: .leading) {
            Text(event.title)
                .font(.title3)
                .bold()
                .foregroundColor(event.textColor)
            Text(formattedDate(event.date))
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.dateTimeStyle = .named
        return formatter.string(for: event.date) ?? "Unknown Date"
    }
}

#Preview {
    List {
        EventRow(event: .victoryday, currentDate: Date())
    }
}
