//
//  UpdateNoteUseCase.swift
//  Testing
//
//  Created by Uri on 21/1/24.
//

import Foundation

protocol UpdateNoteProtocol {
    func updateNoteWith(identifier: UUID, title: String, text: String?) throw
}

struct UpdateNoteUseCase: UpdateNoteProtocol {
    var notesDatabase: NotesDatabaseProtocol
    
    init(notesDatabase: NotesDatabaseProtocol = NotesDatabase.shared) {
        self.notesDatabase = notesDatabase
    }
    
    func updateNoteWith(identifier: UUID, title: String, text: String?) throws {
        try notesDatabase.update(identifier: identifier, title: title, text: text)
    }
}
