//
//  RemoveNoteUseCase.swift
//  Testing
//
//  Created by Uri on 14/12/23.
//

import Foundation

protocol RemoveNoteProtocol {
    func removeNoteWith(identifier: UUID) throws
}

struct RemoveNoteUseCase: RemoveNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    // remove a note and send it to NotesDatabase
    func removeNoteWith(identifier: UUID) throws {
        try notesDatabase.remove(identifier: identifier)
    }
}
