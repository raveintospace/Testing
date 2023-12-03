//
//  CreateNoteView.swift
//  Testing
//
//  Created by Uri on 3/12/23.
//

import SwiftUI

struct CreateNoteView: View {
    
    var viewModel: ViewModel
    
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            createNoteForm
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        xMarkDismissButton
                    }
                    
                    ToolbarItem {
                        createNoteButton
                    }
                }
                .navigationTitle("New note")
                .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    CreateNoteView(viewModel: .init())
}

extension CreateNoteView {
    
    private var createNoteForm: some View {
        Form {
            Section {
                TextField("", text: $title, prompt: Text("*Title"), axis: .vertical)
                TextField("", text: $text, prompt: Text("Text"), axis: .vertical)
            } footer: {
                Text("*Title is compulsory")
            }
        }
    }
    
    private var xMarkDismissButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "x.circle")
        }
    }
    
    private var createNoteButton: some View {
        Button {
            viewModel.createNoteWith(title: title, text: text)
        } label: {
            Text("Create Note")
                .bold()
        }
    }
}
