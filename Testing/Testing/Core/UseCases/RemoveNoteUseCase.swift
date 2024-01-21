//
//  RemoveNoteUseCase.swift
//  Testing
//
//  Created by Uri on 14/12/23.
//

import Foundation

protocol RemoveNoteProtocol {
    func removeNote(note: Note) throws
}

struct RemoveNoteUseCase: RemoveNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    // remove a note and send it to NotesDatabase
    func removeNote(note: Note) throws {
        try notesDatabase.remove(note: note)
    }
}
