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
    @State private var sortedType : SortTypeEnum = .title
    @State private var filter: String = ""
    var body: some View {
        NavigationStack {
            Picker("Sort By", selection: $sortedType) {
                ForEach(SortTypeEnum.allCases) { sortType in
                   Text( sortType.rawValue).tag(sortType)
                    
                }
            }.buttonStyle(.bordered)
                .foregroundStyle(Color.blue)
            BookList(sortOrder: sortedType,filterString: filter)
                .searchable(text: $filter, prompt: "filter by author ")
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
