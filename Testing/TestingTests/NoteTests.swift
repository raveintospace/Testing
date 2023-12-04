//
//  NoteTests.swift
//  NoteTests
//
//  Created by Uri on 4/12/23.
//

import XCTest
@testable import Testing

final class NoteTests: XCTestCase {

    func test_Note_Initialization_shouldBeEqualToPropertiesValues() {
        // Given
        let title = "Test title"
        let text = "Test text"
        let date = Date()
        
        // When
        let note = Note(title: title, text: text, createdAt: date)
        
        // Then
        XCTAssertEqual(note.title, title)
        XCTAssertEqual(note.text, text)
        XCTAssertEqual(note.createdAt, date)
    }
}
