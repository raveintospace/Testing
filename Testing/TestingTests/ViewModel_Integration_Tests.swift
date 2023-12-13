//
//  ViewModel_Integration_Tests.swift
//  TestingTests
//
//  Created by Uri on 13/12/23.
//

import XCTest
@testable import Testing

@MainActor
final class ViewModel_Integration_Tests: XCTestCase {
    var sut: ViewModel!

    override func setUpWithError() throws {
        let database = NotesDatabase.shared     // -> only available when testing
        database.container = NotesDatabase.setupContainer(inMemory: true)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: database)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDatabase: database)
        
        sut = ViewModel(createNoteUseCase: createNoteUseCase,
                        fetchAllNotesUseCase: fetchAllNotesUseCase)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    

}
