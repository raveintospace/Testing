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
            Form {
                Section {
                    TextField("", text: $title, prompt: Text("*Title"), axis: .vertical)
                    TextField("", text: $text, prompt: Text("Text"), axis: .vertical)
                } footer: {
                    Text("*Title is compulsory")
                }
            }
        }
        .navigationTitle("New note")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    CreateNoteView(viewModel: .init())
}
