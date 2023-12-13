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
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
    }

    func test_ViewModel_createNoteWith_appendsNewNoteWithEqualValues() {
        // Given
        let title = "Test title"
        let text = "Test text"
        
        // When
        viewModel.createNoteWith(title: title, text: text)
        
        // Then
        XCTAssertEqual(viewModel.notes.count, 1)
        XCTAssertEqual(viewModel.notes.first?.title, title)
        XCTAssertEqual(viewModel.notes.first?.text, text)
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
        viewModel.createNoteWith(title: title, text: text)
        viewModel.createNoteWith(title: title2, text: text2)
        viewModel.createNoteWith(title: title3, text: text3)
        
        
        // Then
        XCTAssertEqual(viewModel.notes.count, 3)
        XCTAssertEqual(viewModel.notes.first?.title, title)
        XCTAssertEqual(viewModel.notes.first?.text, text)
        XCTAssertEqual(viewModel.notes[1].title, title2)
        XCTAssertEqual(viewModel.notes[1].text, text2)
        XCTAssertEqual(viewModel.notes[2].title, title3)
        XCTAssertEqual(viewModel.notes[2].text, text3)
    }
    
    func test_ViewModel_updateNoteWith_updatesNoteValues() {
        // Given
        let title = "Test title"
        let text = "Test text"
        viewModel.createNoteWith(title: title, text: text)
        
        let newTitle = "New title"
        let newText = "New text"
        
        if let identifier = viewModel.notes.first?.identifier {
            
        // When
            viewModel.updateNoteWith(identifier: identifier, newTitle: newTitle, newText: newText)
            
        // Then
            XCTAssertEqual(viewModel.notes.first?.title, newTitle)
            XCTAssertEqual(viewModel.notes.first?.text, newText)
        } else {
            XCTFail("No note to update")
        }
    }
    
    func test_ViewModel_removeNoteWith_removesNote() {
        // Given
        let title = "Test title"
        let text = "Test text"
        viewModel.createNoteWith(title: title, text: text)
        
        if let identifier = viewModel.notes.first?.identifier {
            
        // When
            viewModel.removeNoteWith(identifier: identifier)
        
        // Then
            XCTAssertTrue(viewModel.notes.isEmpty)
        } else {
            XCTFail("No note to remove")
        }
    }

}
