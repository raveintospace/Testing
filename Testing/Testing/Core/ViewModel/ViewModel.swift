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
    
    // dependency injection
    var createNoteUseCase: CreateNoteUseCase
    var fetchAllNotesUseCase: FetchAllNotesUseCase
    
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteUseCase = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesUseCase = FetchAllNotesUseCase()) {
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
    }
    
    func createNoteWith(title: String, text: String) {
        do {
            try createNoteUseCase.createNoteWith(title: title, text: text)
            fetchAllNotes()
        } catch {
            debugPrint("Error \(error.localizedDescription)")
        }
    }
    
    func fetchAllNotes() {
        do {
            notes = try fetchAllNotesUseCase.fetchAll()
        } catch {
            debugPrint("Error \(error.localizedDescription)")
        }
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
