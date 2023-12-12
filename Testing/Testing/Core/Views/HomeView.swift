//
//  ContentView.swift
//  Testing
//
//  Created by Uri on 3/12/23.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
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
                .navigationTitle("Notes")
                .navigationDestination(for: Note.self, destination: { note in
                    UpdateNoteView(viewModel: viewModel, identifier: note.identifier, title: note.title, text: note.getText)
                })
                .fullScreenCover(isPresented: $showCreateNote, content: {
                    CreateNoteView(viewModel: viewModel)
                })
        }
    }
}

#Preview {
    HomeView(viewModel: .init(notes: [
        .init(title: "Note 1", text: "Text 1", createdAt: .now),
        .init(title: "Note 2", text: "Text 2", createdAt: .now),
    ]))
}

extension HomeView {
    
    private var listOfNotes: some View {
        List {
            ForEach(viewModel.notes) { note in
                NavigationLink(value: note) {
                    VStack(alignment: .leading) {
                        Text(note.title)
                            .foregroundStyle(.primary)
                        Text(note.getText)
                            .foregroundStyle(.secondary)
                    }
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
