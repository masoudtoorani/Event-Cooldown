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
                .toolbar { addButton }
                .navigationDestination(for: Event.self) { event in
                    if let binding = bindingForEvent(event) {
                        EventForm(
                            mode: .edit(event: event),
                            onSave: { updatedEvent in
                                binding.wrappedValue = updatedEvent
                                events.sort()
                            }
                    )}
                }
        }
    }
    
    private var eventsList: some View {
        List {
            ForEach(events.sorted()) { event in
                NavigationLink(value: event) {
                    EventRow(event: event, currentDate: Date())
                        .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
                }
            .onDelete(perform: deleteEvent)
        }
    }
    
    private func bindingForEvent(_ event: Event) -> Binding<Event>? {
        guard let index = events.firstIndex(where: { $0.id == event.id }) else { return nil }
        return $events[index]
    }
    
    private func deleteEvent(at offsets: IndexSet) {
        events.remove(atOffsets: offsets)
        events.sort()
    }
    
    private var addButton: some View {
        NavigationLink(destination: EventForm(
            mode: .add,
            onSave: { event in
                events.append(event)
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
