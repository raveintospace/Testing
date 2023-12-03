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

    var body: some View {
        NavigationStack {
            listOfNotes
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
}
