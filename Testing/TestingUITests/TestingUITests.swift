//
//  TestingUITests.swift
//  TestingUITests
//
//  Created by Uri on 30/1/24.
//

import XCTest

final class TestingUITests: XCTestCase {
    
    func test_createNote() throws {
        
        // launch the app to test
        let app = XCUIApplication()
        app.launch()
        app.toolbars["Toolbar"].staticTexts["Create Note"].tap()
        
        let collectionViewsQuery = app.collectionViews
        let titleTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView.tap()
        titleTextView.typeText("Subscribe")
        
        let textTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textTextView.tap()
        textTextView.typeText("To testing")
        
        app.navigationBars["New note"].buttons["Create note"].tap()
    }
    
    func test_removeNote() throws {
        let app = XCUIApplication()
        app.launch()
        app.toolbars["Toolbar"].staticTexts["Create note"].tap()
        
        let collectionViewsQuery = app.collectionViews
        let titleTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_title_identifier").element
        titleTextView.tap()
        titleTextView.typeText("Subscribe1")
        
        let textTextView = collectionViewsQuery.textViews.matching(identifier: "createnote_text_identifier").element
        textTextView.tap()
        textTextView.typeText("To testing1")
        
        app.navigationBars["New note"].buttons["Create note"].tap()
        
        // remove note
        let firstNote = collectionViewsQuery.cells.element(boundBy: 0)
        firstNote.tap()
        app.buttons["Remove Note"].tap()
    }
}
