//
//  ContentView.swift
//  Testing
//
//  Created by Uri on 3/12/23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    var viewModel: ViewModel = .init()
    
    @State private var showCreateNote: Bool = false
    
    var body: some View {
        NavigationStack {
            listOfNotes
                .toolbar {
                    ToolbarItem(placement: .status) {
                        createNoteButton
                    }
                }
        }
    }
}

#Preview {
    ContentView(viewModel: .init(notes: [
        .init(title: "Note 1", text: "Text 1", createdAt: .now),
        .init(title: "Note 2", text: "Text 2", createdAt: .now),
    ]))
}

extension ContentView {
    
    private var listOfNotes: some View {
        List {
            ForEach(viewModel.notes) { note in
                VStack(alignment: .leading) {
                    Text(note.title)
                        .foregroundStyle(.primary)
                    Text(note.getText)
                        .foregroundStyle(.secondary)
                }
            }
        }
    }
    
    private var createNoteButton: some View {
        Button(action: {
            showCreateNote.toggle()
        }, label: {
            Label("Create Note", systemImage: "square.and.pencil")
                .labelStyle(TitleAndIconLabelStyle())
        })
        .buttonStyle(.bordered)
        .tint(.blue)
        .bold()
    }
}
