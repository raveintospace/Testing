//
//  CreateNoteUseCase.swift
//  Testing
//
//  Created by Uri on 12/12/23.
//

import Foundation

struct CreateNoteUseCase {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    // create a note and send it to NotesDatabase
    func createNoteWith(title: String, text: String) throws {
        let note: Note = .init(identifier: .init(), title: title, text: text, createdAt: .now)
        try notesDatabase.insert(note: note)
    }
}
