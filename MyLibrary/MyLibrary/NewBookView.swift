//
//  NewBookView.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 31/12/2025.
//

import SwiftUI
import SwiftData

struct NewBookView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var context
    @State private var title: String = ""
    @State private var author: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)
                TextField("Author", text: $author)
                Button("Add Book") {
                    let newBook = Book(title: title, author: author)
                    context.insert(newBook)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .disabled(title.isEmpty || author.isEmpty)
                .navigationTitle("New Book")
                .navigationBarBackButtonHidden(true)
                

            }
            .toolbar{
//                ToolbarItem(placement: .topBarLeading) {
//                        Button("Cancel") {
//                            dismiss()
//                        }
//                    }
               
            }
        }
    }
}

#Preview {
    NewBookView()
}
