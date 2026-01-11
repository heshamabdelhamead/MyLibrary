//
//  AddNewGenre.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 11/01/2026.
//

import SwiftUI
import SwiftData

struct AddNewGenre: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    @State private var name: String = ""
    @State private var color = Color.red
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                ColorPicker("Set the Grenre Color", selection: $color)
                Button("Create") {
                    let genre = GenreModel(name: name, color: color.toHexString()!)
                    context.insert(genre)
                    dismiss()
                }
                .buttonStyle(.borderedProminent)
                .frame(alignment: .trailing)
                .disabled(name.isEmpty)
            }
            .padding()
            .navigationTitle("Add New Genre")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
}

#Preview {
 //   AddNewGenre()
}
