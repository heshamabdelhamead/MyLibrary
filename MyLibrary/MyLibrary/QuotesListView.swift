//
//  QuotesListView.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 09/01/2026.
//

import SwiftUI
import SwiftData
struct QuotesListView: View {
    @Environment(\.modelContext) private var modelContext
    let book : BookModel
    @State private var text = ""
    @State private var page = ""
    @State private var SelectedQuote: QuoteModel?
    var isEditing : Bool{
        SelectedQuote != nil
    }
    var body: some View {
        GroupBox {
            HStack {
                LabeledContent( "Page"){
                    TextField("Page", text: $page)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .autocorrectionDisabled()
                        .frame(width: 150)
                    Spacer()
                    
                }
                if isEditing {
                    Button("Cancel"){
                        page = ""
                        text = ""
                        SelectedQuote = nil
                    }
                    
                    .buttonStyle(.bordered)
                }
                    Button( isEditing ? "Update":"Create"){
                        if isEditing {
                            SelectedQuote?.text = text
                            SelectedQuote?.page = page.isEmpty ? nil : page
                            page = ""
                            text = ""
                            SelectedQuote = nil
                        }else {
                      let quote =  page.isEmpty ? QuoteModel(text: text) : QuoteModel(text: text, page: page)
                            book.quotes?.append(quote)
                            text = ""
                            page = ""
                        }
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(text.isEmpty)
                }
                    TextEditor(text: $text)
                    .border(Color.secondary)
                    .frame(height: 100)
            }
        .padding(.horizontal)
        
        
        List{
            let sortedQuotes = book.quotes?.sorted(using: KeyPathComparator(\QuoteModel.createdDate))  ?? []
            ForEach(sortedQuotes){ quote in
                VStack(alignment: .leading) {
                    Text("\(quote.createdDate)")
                        .foregroundStyle(.secondary)
                        .font(.caption)
                    Text(quote.text)
                        .font(.title2)
                    HStack{
                        Spacer()
                    if  let page = quote.page , !page.isEmpty  {
                        Text( "page:\( page)")
                    }
                    }
                    
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    SelectedQuote = quote
                    text = quote.text
                    page = quote.page ?? ""
                }
                
            }.onDelete { indexSet in
                withAnimation {
                    indexSet.forEach { index in
                        if let quote = book.quotes?[index]{
                            book.quotes?.forEach { curentQuote in
                                if quote.id == curentQuote.id{
                                    modelContext.delete(quote)
                                }
                            }
                        }
                        
                    }
                }
            }
            
        }
        .listStyle(.plain)
        .navigationTitle("Quotes")
    }
}

#Preview {
  //  QuotesListView()
}
