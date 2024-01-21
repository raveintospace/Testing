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
    var createNoteUseCase: CreateNoteProtocol
    var fetchAllNotesUseCase: FetchAllNotesProtocol
    var removeNoteUseCase: RemoveNoteProtocol
    
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesProtocol = FetchAllNotesUseCase(),
         removeNoteUseCase: RemoveNoteProtocol = RemoveNoteUseCase()) {
        
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        self.removeNoteUseCase = removeNoteUseCase
        
        fetchAllNotes()
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
        //notes.removeAll(where: { $0.identifier == identifier })
        
        if let index = notes.firstIndex(where: { $0.identifier == identifier }) {
            let noteToRemove = Note(identifier: identifier, title: notes[index].title, text: notes[index].text, createdAt: notes[index].createdAt)
            do {
                try removeNoteUseCase.removeNote(note: noteToRemove)
                fetchAllNotes()
            } catch {
                debugPrint("Error \(error.localizedDescription)")
            }
        }
    }
}
