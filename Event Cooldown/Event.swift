//
//  Event.swift
//  Event Cooldown
//
//  Created by Masoud Toorani on 3.11.2024.
//

import Foundation
import SwiftUI

struct Event: Comparable, Identifiable, Hashable {
    var id = UUID()
    var title: String
    var date: Date
    var textColor: Color
    
    static func < (lhs: Event, rhs: Event) -> Bool {
        lhs.date < rhs.date
    }
}

class EventList: ObservableObject {
    @Published var events: [Event] = Event.all
}

extension Event {
    static var all: [Event] = [
        .newyear,
        .halloween,
        .christmas,
        .victoryday
    ]
}

extension Event {
    static var newyear = Event(
        title: "New Year 🥳",
        date: Date(timeIntervalSinceNow: 3600),
        textColor: .blue
    )
    
    static var halloween = Event(
        title: "Halloween 🎃",
        date: Date(timeIntervalSinceNow: -7200),
        textColor: .orange
    )
    
    static var christmas = Event(
        title: "Christmas 🎄",
        date: Date(timeIntervalSinceNow: 84000),
        textColor: .green
    )
    
    static var victoryday = Event(
        title: "Victory Day 🇹🇷",
        date: Date(timeIntervalSinceNow: 1268000),
        textColor: .red
    )
}
