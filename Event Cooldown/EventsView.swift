//
//  EventsView.swift
//  Event Cooldown
//
//  Created by Masoud Toorani on 3.11.2024.
//

import SwiftUI

struct EventsView: View {
    @State private var events: [Event] = Event.all
    @State private var newEvent = Event(title: "", date: Date(), textColor: .green)
    var currentDate: Date
    
    var body: some View {
        NavigationStack {
            eventsList
                .navigationTitle("Events")
                .toolbar {
                    addButton
                }
        }
    }
    
    private var eventsList: some View {
            List {
                ForEach(events.sorted()) { event in
                    NavigationLink(
                        destination: EventForm(
                            event: Binding(
                                get: { event },
                                set: { updatedEvent in
                                    if let index = events.firstIndex(where: { $0.id == updatedEvent.id }) {
                                        events[index] = updatedEvent
                                    }
                                }
                            ),
                            isNewEvent: false,
                            onSave: { _ in }
                        )
                    ) {
                        EventRow(event: event, currentDate: Date())  // Fixed binding issue here
                    }
                }
                .onDelete(perform: deleteEvent)
            }
    }
    
    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
        events.sort()
    }
    
    private var addButton: some View {
        NavigationLink(destination: EventForm(
            event: $newEvent,
            isNewEvent: true,
            onSave: { event in
                events.append(event)
                newEvent = Event(title: "", date: Date(), textColor: .green)
                events.sort()
            }
        )) {
            Label("Add Event", systemImage: "plus")
        }
    }
}

#Preview {
    EventsView(currentDate: Date())
}
