//
//  ViewModel_Integration_Tests.swift
//  TestingTests
//  Test integration among different actors: ViewModel - UseCases - Database
//  Created by Uri on 13/12/23.
//

import XCTest
@testable import Testing

@MainActor
final class ViewModel_Integration_Tests: XCTestCase {
    var sut: ViewModel!

    override func setUpWithError() throws {
        let database = NotesDatabase.shared     // -> only available when testing
        database.container = NotesDatabase.setupContainer(inMemory: true)  // -> save in memory (test), not in disk (prod)
        
        let createNoteUseCase = CreateNoteUseCase(notesDatabase: database)
        let fetchAllNotesUseCase = FetchAllNotesUseCase(notesDatabase: database)
        let removeNoteUseCase = RemoveNoteUseCase(notesDatabase: database)
        let updateNoteUseCase = UpdateNoteUseCase(notesDatabase: database)
        
        sut = ViewModel(createNoteUseCase: createNoteUseCase,
                        fetchAllNotesUseCase: fetchAllNotesUseCase,
                        removeNoteUseCase: removeNoteUseCase,
                        updateNoteUseCase: updateNoteUseCase)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // test if VM calls UseCase and it calls Database to insert a new note
    func test_createNote() {
        // Given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        
        // When
        let note = sut.notes.first
        
        // Then
        XCTAssertNotNil(note)
        XCTAssertEqual(note?.title, "Hello 1")
        XCTAssertEqual(note?.text, "text 1")
        XCTAssertEqual(sut.notes.count, 1, "There should be one note in database")
    }
    
    func test_createTwoNotes() {
        // Given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        sut.createNoteWith(title: "Hello 2", text: "text 2")
        
        // When
        let firstNote = sut.notes.first
        let lastNote = sut.notes.last
        
        // Then
        XCTAssertNotNil(firstNote)
        XCTAssertEqual(firstNote?.title, "Hello 1")
        XCTAssertEqual(firstNote?.text, "text 1")
        XCTAssertNotNil(lastNote)
        XCTAssertEqual(lastNote?.title, "Hello 2")
        XCTAssertEqual(lastNote?.text, "text 2")
        XCTAssertEqual(sut.notes.count, 2, "There should be two notes in database")
    }
    
    func test_fetchAllNotes() {
        // Given
        sut.createNoteWith(title: "Hello 1", text: "text 1")
        sut.createNoteWith(title: "Hello 2", text: "text 2")
        
        // When
        let firstNote = sut.notes[0]
        let secondNote = sut.notes[1]
        
        // Then
        XCTAssertEqual(sut.notes.count, 2, "There should be two notes in database")
        XCTAssertEqual(firstNote.title, "Hello 1", "First note's title should be 'Hello 1'")
        XCTAssertEqual(firstNote.text, "text 1", "First note's text should be 'text 1'")
        XCTAssertEqual(secondNote.title, "Hello 2", "Second note's title should be 'Hello 2'")
        XCTAssertEqual(secondNote.text, "text 2", "Second note's text should be 'text 2'")
    }
    
    func test_removeNote() {
        // Given
        sut.createNoteWith(title: "Note 1", text: "text 1")
        sut.createNoteWith(title: "Note 2", text: "text 2")
        sut.createNoteWith(title: "Note 3", text: "text 3")
        
        guard let note = sut.notes.last else {
            XCTFail()
            return
        }
        
        // When
        sut.removeNoteWith(identifier: note.identifier)
        
        // Then
        XCTAssertEqual(sut.notes.count, 2, "There should be two notes in database")
        
    }
    
    // try to remove a note that doesn't exist
    func test_removeNoteInDatabaseShouldThrowError() {
        // When
        sut.removeNoteWith(identifier: UUID())
        
        // Then
        XCTAssertEqual(sut.notes.count, 0)
        XCTAssertNotNil(sut.databaseError)
        XCTAssertEqual(sut.databaseError, DatabaseError.errorRemove)
    }
    
    func test_updateNote() {
        // Given
        sut.createNoteWith(title: "Note 1", text: "text 1")
        
        guard let note = sut.notes.first else {
            XCTFail()
            return
        }
        
        // When
        sut.updateNoteWith(identifier: note.identifier, newTitle: "New title", newText: "New text")
        sut.fetchAllNotes()
        
        // Then
        XCTAssertEqual(sut.notes.count, 1, "There should be one note in database")
        XCTAssertEqual(note.title, "New title")
        XCTAssertEqual(note.text, "New text")
    }
}
