//
//  BookListView.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 30/12/2025.
//

import SwiftUI
import SwiftData
struct BookListView: View {
    @State var  createNewBook: Bool = false
    @Query var books: [Book]
    @Environment(\.modelContext) private var context
    var body: some View {
        NavigationStack {
            VStack {
                if books.isEmpty {
                ContentUnavailableView("There is No Books ", systemImage:   "book.fill", description:Text( "You didn't added books yet"))
                }else{
                    List{
                        ForEach(books){book in
                            NavigationLink{
                                UpdateBook(book: book)
                            }label:{
                                HStack{
                                    book.icon
                                    VStack{
                                        Text(book.title).font(.title2)
                                        Text(book.author).foregroundStyle(.secondary)
                                        HStack{
                                            if let rating = book.rating {
                                                ForEach(1..<rating , id: \.self){_ in
                                                    Image(systemName:"star.fill")
                                                        .imageScale(.small)
                                                        .foregroundStyle(.yellow)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .onDelete { indexSet in
                            indexSet.forEach { index in
                                let bookToDelete = books[index]
                                context.delete(bookToDelete)
                               
                            }
                        }
                    }
                    .listStyle(.plain)
                }
            }
        
            .padding()
            .toolbar {
                Button {
                    createNewBook = true 
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .imageScale(.large)
                }
        }
            .sheet(isPresented:  $createNewBook) {
                NewBookView()
                    .presentationDetents([.medium])
            }

        }
        
    }
}

#Preview {
    BookListView()
}
