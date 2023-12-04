//
//  ViewModel_Tests.swift
//  TestingTests
//
//  Created by Uri on 4/12/23.
//

import XCTest
@testable import Testing

final class ViewModel_Tests: XCTestCase {
    var viewModel: ViewModel!

    override func setUpWithError() throws {
        viewModel = ViewModel()
    }

    override func tearDownWithError() throws {
    }

    func test_ViewModel_createNote_appendsNewNoteWithEqualValues() {
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
    
    func test_ViewModel_createNote_appendsThreeNewNotesWithEqualValues() {
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

}
