//
//  UpdateNoteView.swift
//  Testing
//
//  Created by Uri on 3/12/23.
//

import SwiftUI

struct UpdateNoteView: View {
    var viewModel: ViewModel
    
    let identifier: UUID
    
    @State var title: String = ""
    @State var text: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            updateNoteForm
            removeNoteButton
            Spacer()
        }
        .background(Color(uiColor: .systemGroupedBackground))
        .toolbar {
            ToolbarItem {
                saveNoteButton
            }
        }
        .navigationTitle("Update note")
    }
}

#Preview {
    NavigationStack {
        UpdateNoteView(viewModel: .init(), identifier: .init(), title: "Dummy title", text: "Dummy text to see the textfield with several characters")
    }
}

extension UpdateNoteView {
    
    private var updateNoteForm: some View {
        Form {
            Section {
                TextField("", text: $title, prompt: Text("*Title"), axis: .vertical)
                    .autocorrectionDisabled()
                TextField("", text: $text, prompt: Text("Text"), axis: .vertical)
                    .autocorrectionDisabled()
            }
        }
    }
    
    private var saveNoteButton: some View {
        Button {
            viewModel.updateNoteWith(identifier: identifier, newTitle: title, newText: text)
            dismiss()
        } label: {
            Image(systemName: "checkmark.circle")
        }
    }
    
    private var removeNoteButton: some View {
        Button(action: {
            viewModel.removeNoteWith(identifier: identifier)
            dismiss()
        }, label: {
            Image(systemName: "trash.circle")
                .font(.title)
                .foregroundStyle(Color.red)
        })
        .buttonStyle(BorderlessButtonStyle())
    }
}
