//
//  CreateNoteView_SnapshotTest.swift
//  TestingTests
//
//  Created by Uri on 23/1/24.
//

import XCTest
import SnapshotTesting
@testable import Testing

final class CreateNoteView_SnapshotTest: XCTestCase {

    func test_createNoteView() throws {
        let createNoteView = CreateNoteView(viewModel: .init()) // empty viewModel from scratch
        assertSnapshot(of: createNoteView, as: .image)
    }
    
    func test_createNoteViewWithData() {
        let createNoteView = CreateNoteView(viewModel: .init(), title: "Title test", text: "Text test")
        assertSnapshot(of: createNoteView, as: .image)
    }
}
