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
    case errorUpdate
    case errorRemove
}

protocol NotesDatabaseProtocol {
    func insert(note: Note) throws
    func fetchAll() throws -> [Note]
    
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
}
