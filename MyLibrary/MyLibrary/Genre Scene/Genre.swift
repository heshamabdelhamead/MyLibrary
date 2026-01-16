//
//  Genre.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 11/01/2026.
//

import SwiftUI
import SwiftData

struct Genre: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @Bindable var book : BookModel
    @Query(sort: \GenreModel.name) var genres : [GenreModel]
    @State private var newGenre : Bool = false
    var body: some View {
        NavigationStack{
            Group{
                if genres.isEmpty {
                    ContentUnavailableView {
                        Image(systemName: "bookmark.fill")
                    } description: {
                        Text("you need to create some genres first")
                    } actions: {
                        Button("Create Genre" ){
                            newGenre.toggle()
                        }.buttonStyle(.borderedProminent)
                    }
                    
                }else{
                    List {
                        ForEach(genres) { genre in
                            HStack{
                                if let bookGenres = book.genres{
                                    if bookGenres.isEmpty{
                                        Button {
                                            addRemoveGenre(genre: genre)
                                        }label: {
                                            Image(systemName: "circle")
                                        }
                                        .foregroundStyle(genre.hexColor)
                                    }else {
                                        Button {
                                            addRemoveGenre(genre: genre)
                                        }label: {
                                            Image(systemName: bookGenres.contains(genre) ? "circle.fill" : "circle")
                                        }
                                        .foregroundStyle(genre.hexColor)
                                    }
                                }
                                Text(genre.name)
                            }
                        }
                        .onDelete { indexSet in
                    
                            indexSet.forEach { index in
                                let genre = self.genres[index]
                                //remove the genre form editBook scene in case of removing the genre
                                book.genres?.removeAll(where: { $0.id == genre.id })
                                modelContext.delete(genre)
                            }
                        }
                        LabeledContent {
                            Button{
                                //present adding new genre
                                newGenre.toggle()
                                
                            }label: {
                                Image(systemName: "plus.circle.fill")
                                    .imageScale(.large)
                            }
                            .buttonStyle(.borderedProminent)
                        } label: {
                            Text("Create New Genre")
                                .font(.caption).foregroundStyle(.secondary)
                        }

                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(book.title)
            .sheet(isPresented: $newGenre) {
                AddNewGenre()
            }
            .toolbar {
                ToolbarItem( placement : .topBarTrailing) {
                    Button("Done"){
                        dismiss()
                    }
                }
            }
            
        }
        
    }
    func addRemoveGenre(genre: GenreModel){
        if let bookGenres = book.genres{
            if bookGenres.isEmpty{
                self.book.genres?.append(genre)
            }else {
                if bookGenres.contains(genre),
                   let index = bookGenres.firstIndex( where :{ $0.id == genre.id}){
                    self.book.genres?.remove(at: index)
                }else{
                    self.book.genres?.append(genre)
                }
            }
        }
    }
}

#Preview {
    //Genre()
}
