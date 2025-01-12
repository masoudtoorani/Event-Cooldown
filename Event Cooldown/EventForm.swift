//
//  EventForm.swift
//  Event Cooldown
//
//  Created by Masoud Toorani on 3.11.2024.
//

import SwiftUI

struct EventForm: View {
    
    enum FormMode {
        case add
        case edit(event: Event)
    }
    
    @Environment(\.dismiss) var dismiss
    @State private var draftEvent: Event
    var mode: FormMode
    var onSave: (Event) -> Void
    
    init(mode: FormMode, onSave: @escaping (Event) -> Void) {
        self.mode = mode
        switch mode {
        case .add:
            _draftEvent = State(initialValue: Event(title: "", date: Date(), textColor: .red))
        case .edit(let event):
            _draftEvent = State(initialValue: event)
        }
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
                Text(modeTitle)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .bold()
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save", systemImage: "checkmark") {
                    onSave(draftEvent)
                    dismiss()
                }
                .disabled(draftEvent.title.trimmingCharacters(in: .whitespaces).isEmpty) // Disabling adding new event when title is empty or just space
            }
        }
    }
    
    private var modeTitle: String {
        switch mode {
        case .add:
            return "Add Event"
        case .edit(let event):
            return "Edit \(event.title)"
        }
    }
}

#Preview {
    EventForm(mode: .add) { _ in }
}
