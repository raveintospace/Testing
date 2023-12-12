//
//  ViewModel.swift
//  Testing
//  Logic: Create, update & remove notes
//  Created by Uri on 3/12/23.
//

import Foundation
import Observation

@Observable
class ViewModel {
    var notes: [Note]
    
    init(notes: [Note] = []) {
        self.notes = notes
    }
    
    func createNoteWith(title: String, text: String) {
        let note: Note = .init(title: title, text: text, createdAt: .now)
        notes.append(note)
    }
    
    func updateNoteWith(identifier: UUID, newTitle: String, newText: String?) {
        if let index = notes.firstIndex(where: { $0.identifier == identifier }) {
            let updatedNote = Note(identifier: identifier, title: newTitle, text: newText, createdAt: notes[index].createdAt)
            notes[index] = updatedNote
        }
    }
    
    func removeNoteWith(identifier: UUID) {
        notes.removeAll(where: { $0.identifier == identifier })
    }
}
