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
    var updateNoteUseCase: UpdateNoteProtocol
    
    init(notes: [Note] = [],
         createNoteUseCase: CreateNoteProtocol = CreateNoteUseCase(),
         fetchAllNotesUseCase: FetchAllNotesProtocol = FetchAllNotesUseCase(),
         removeNoteUseCase: RemoveNoteProtocol = RemoveNoteUseCase(),
         updateNoteUseCase: UpdateNoteProtocol = UpdateNoteUseCase()) {
        
        self.notes = notes
        self.createNoteUseCase = createNoteUseCase
        self.fetchAllNotesUseCase = fetchAllNotesUseCase
        self.removeNoteUseCase = removeNoteUseCase
        self.updateNoteUseCase = updateNoteUseCase
        
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
    
    func removeNoteWith(identifier: UUID) {
        do {
            try removeNoteUseCase.removeNoteWith(identifier: identifier)
            fetchAllNotes()
        } catch {
            debugPrint("Error \(error.localizedDescription)")
        }
    }
    
    func updateNoteWith(identifier: UUID, newTitle: String, newText: String?) {
        do {
            try updateNoteUseCase.updateNoteWith(identifier: identifier, title: newTitle, text: newText)
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
}
