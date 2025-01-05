//
//  EventForm.swift
//  Event Cooldown
//
//  Created by Masoud Toorani on 3.11.2024.
//

import SwiftUI

struct EventForm: View {
    @Environment(\.dismiss) var dismiss
    @Binding var event: Event
    @State private var draftEvent: Event
    var isNewEvent: Bool
    var onSave: (Event) -> Void
    
    init(event: Binding<Event>, isNewEvent: Bool, onSave: @escaping (Event) -> Void) {
        self._event = event
        self._draftEvent = State(initialValue: event.wrappedValue)  // Temporary copy for edits
        self.isNewEvent = isNewEvent
        self.onSave = onSave
    }
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    TextField("Title", text: $draftEvent.title)
                        .font(.headline)
                        .foregroundColor(draftEvent.textColor)
                    DatePicker("Date", selection: $draftEvent.date)
                        .environment(\.locale, Locale(identifier: "en_US"))
                    ColorPicker("Text Color", selection: $draftEvent.textColor)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(isNewEvent ? "Add Event" : "Edit \(event.title)")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .bold()
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", systemImage: "checkmark") {
                    event = draftEvent
                    onSave(draftEvent)
                    dismiss()
                }
                .disabled(draftEvent.title.trimmingCharacters(in: .whitespaces).isEmpty) // Disabling adding new event when title is empty or just space
            }
        }
    }
}

#Preview {
    EventForm(event: .constant(Event(title: "", date: Date(), textColor: .green)),
              isNewEvent: true,
              onSave: { _ in })
}
