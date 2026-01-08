//
//  BookList.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 06/01/2026.
//

import SwiftUI
import SwiftData

struct BookList: View {
    @Query private  var books: [Book]
    @Environment(\.modelContext) private var context
    
    init(sortOrder: SortTypeEnum,filterString:String){
        let sortDescriptors: [SortDescriptor<Book>] = switch sortOrder {
            case .title:
            [SortDescriptor(\Book.title) ]
        case .author:
            [SortDescriptor(\Book.author) ]
        case .status:
            [SortDescriptor(\Book.status),SortDescriptor(\Book.title) ]
        }
        let predicate = #Predicate<Book>{ book in book.title.localizedStandardContains(filterString) || book.author.localizedStandardContains(filterString) || filterString.isEmpty
        
        }
        _books = Query(filter: predicate, sort: sortDescriptors)
       // _books = Query( sort: sortDescriptors)
    }
    var body: some View {
        Group {
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
                   // .onDelete(perform: deleteBooks)
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            let bookToDelete = books[index]
                            context.delete(bookToDelete)
                        }
//                            do {
//                                try  context.save()
//                            }catch {
//                                print("there is an error saving the book")
//                            }
                   }
                }
                .listStyle(.plain)
            }
        }
    }
}

#Preview {
    BookList(sortOrder: .title,filterString: "")
}
