//
//  Mocks.swift
//  TestingTests
//
//  Created by Uri on 21/1/24.
//

@testable import Testing
import Foundation

// simulates database storage
var mockDatabase: [Note] = []

struct createNoteUseCaseMock: CreateNoteProtocol {
    func createNoteWith(title: String, text: String) throws {
        let note = Note(title: title, text: text, createdAt: .now)
        mockDatabase.append(note)
    }
}

struct fetchAllNotesUseCaseMock: FetchAllNotesProtocol {
    func fetchAll() throws -> [Testing.Note] {
        return mockDatabase
    }
}

struct removeNoteUseCaseMock: RemoveNoteProtocol {
    func removeNoteWith(identifier: UUID) throws {
        if let index = mockDatabase.firstIndex(where: { $0.identifier == identifier }) {
            mockDatabase.remove(at: index)
        }
    }
}

struct updateNoteUseCaseMock: UpdateNoteProtocol {
    func updateNoteWith(identifier: UUID, title: String, text: String?) throws {
        if let index = mockDatabase.firstIndex(where: { $0.identifier == identifier }) {
            mockDatabase[index].title = title
            mockDatabase[index].text = text
        }
    }
}
