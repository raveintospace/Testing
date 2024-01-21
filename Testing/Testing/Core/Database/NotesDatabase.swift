//
//  NotesDatabase.swift
//  Testing
//  SwiftData configuration
//  Created by Uri on 12/12/23.
//

import Foundation
import SwiftData

enum DatabaseError: Error {
    case errorInsert
    case errorFetch
    case errorRemove
    case errorUpdate
}

protocol NotesDatabaseProtocol {
    func insert(note: Note) throws
    func fetchAll() throws -> [Note]
    func remove(identifier: UUID) throws
    func update(identifier: UUID, title: String, text: String?) throws
}

class NotesDatabase: NotesDatabaseProtocol {
    static let shared: NotesDatabase = NotesDatabase()
    
    // false for production code
    @MainActor
    var container: ModelContainer = setupContainer(inMemory: false)
    
    private init() {}
    
    // create container
    @MainActor
    static func setupContainer(inMemory: Bool) -> ModelContainer {
        do {
            let container = try ModelContainer(for: Note.self,
                                               configurations: ModelConfiguration(isStoredInMemoryOnly: inMemory))
            container.mainContext.autosaveEnabled = true
            return container
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
            fatalError("Database can't be created")
        }
    }
    
    // store note in memory
    @MainActor
    func insert(note: Note) throws {
        container.mainContext.insert(note)
        
        do {
            try container.mainContext.save()
        } catch {
            debugPrint("Error \(error.localizedDescription)")
            throw DatabaseError.errorInsert
        }
    }
    
    // retrieve stored notes
    @MainActor
    func fetchAll() throws -> [Note] {
        let fetchDescriptor = FetchDescriptor<Note>(sortBy: [SortDescriptor<Note>(\.createdAt)])
        
        do {
            return try container.mainContext.fetch(fetchDescriptor)
        } catch {
            debugPrint("Error \(error.localizedDescription)")
            throw DatabaseError.errorFetch
        }
    }
    
    // remove stored note
    @MainActor
    func remove(identifier: UUID) throws {
        
        // the criteria used to find the note to remove
        let notePredicate = #Predicate<Note> {
            $0.identifier == identifier
        }
        
        // use the criteria defined to fetch the note to remove
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let deleteNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorRemove
            }
            
            container.mainContext.delete(deleteNote)
            try container.mainContext.save()
            
        } catch {
            debugPrint("Error updating info")
            throw DatabaseError.errorRemove
        }
    }
    
    // update stored note
    @MainActor
    func update(identifier: UUID, title: String, text: String?) throws {
        
        // the criteria used to find the note to update
        let notePredicate = #Predicate<Note> {
            $0.identifier == identifier
        }
        
        // use the criteria defined to fetch the note to update
        var fetchDescriptor = FetchDescriptor<Note>(predicate: notePredicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            guard let updateNote = try container.mainContext.fetch(fetchDescriptor).first else {
                throw DatabaseError.errorUpdate
            }
            
            updateNote.title = title
            updateNote.text = text
            try container.mainContext.save()
            
        } catch {
            debugPrint("Error updating info")
            throw DatabaseError.errorUpdate
        }
    }
}
