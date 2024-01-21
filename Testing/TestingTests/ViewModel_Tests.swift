//
//  ViewModel_Tests.swift
//  TestingTests
//
//  Created by Uri on 4/12/23.
//

import XCTest
@testable import Testing

final class ViewModel_Tests: XCTestCase {
    var sut: ViewModel!

    override func setUpWithError() throws {
        sut = ViewModel(createNoteUseCase: createNoteUseCaseMock(),
                        fetchAllNotesUseCase: fetchAllNotesUseCaseMock(),
                        updateNoteUseCase: updateNoteUseCaseMock())
    }

    override func tearDownWithError() throws {
        // reset mockDatabase for every test
        mockDatabase = []
    }

    func test_ViewModel_createNoteWith_appendsNewNoteWithEqualValues() {
        // Given
        let title = "Test title"
        let text = "Test text"
        
        // When
        sut.createNoteWith(title: title, text: text)
        
        // Then
        XCTAssertEqual(sut.notes.count, 1)
        XCTAssertEqual(sut.notes.first?.title, title)
        XCTAssertEqual(sut.notes.first?.text, text)
    }
    
    func test_ViewModel_createNoteWith_appendsThreeNewNotesWithEqualValues() {
        // Given
        let title = "Test title"
        let text = "Test text"
        
        let title2 = "Test title 2"
        let text2 = "Test text 2"
        
        let title3 = "Test title 3"
        let text3 = "Test text 3"
        
        // When
        sut.createNoteWith(title: title, text: text)
        sut.createNoteWith(title: title2, text: text2)
        sut.createNoteWith(title: title3, text: text3)
        
        
        // Then
        XCTAssertEqual(sut.notes.count, 3)
        XCTAssertEqual(sut.notes.first?.title, title)
        XCTAssertEqual(sut.notes.first?.text, text)
        XCTAssertEqual(sut.notes[1].title, title2)
        XCTAssertEqual(sut.notes[1].text, text2)
        XCTAssertEqual(sut.notes[2].title, title3)
        XCTAssertEqual(sut.notes[2].text, text3)
    }
    
    func test_ViewModel_updateNoteWith_updatesNoteValues() {
        // Given
        let title = "Test title"
        let text = "Test text"
        sut.createNoteWith(title: title, text: text)
        
        let newTitle = "New title"
        let newText = "New text"
            
        // When
        if let identifier = sut.notes.first?.identifier {
            sut.updateNoteWith(identifier: identifier, newTitle: newTitle, newText: newText)
            
        // Then
            XCTAssertEqual(sut.notes.first?.title, newTitle)
            XCTAssertEqual(sut.notes.first?.text, newText)
        } else {
            XCTFail("No note to update")
        }
    }
//    
//    func test_ViewModel_removeNoteWith_removesNote() {
//        // Given
//        let title = "Test title"
//        let text = "Test text"
//        sut.createNoteWith(title: title, text: text)
//        
//        if let identifier = sut.notes.first?.identifier {
//            
//        // When
//            sut.removeNoteWith(identifier: identifier)
//        
//        // Then
//            XCTAssertTrue(sut.notes.isEmpty)
//        } else {
//            XCTFail("No note to remove")
//        }
//    }

}
