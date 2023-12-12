//
//  NotesDatabase.swift
//  Testing
//
//  Created by Uri on 12/12/23.
//

import Foundation
import SwiftData

class NotesDatabase {
    static let shared: NotesDatabase = NotesDatabase()
    
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
}
