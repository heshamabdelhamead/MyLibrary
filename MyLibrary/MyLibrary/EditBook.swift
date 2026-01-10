//
//  EditBook.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 01/01/2026.
//

import SwiftUI

struct EditBook: View {
    @Environment(\.dismiss) var dismiss
    @State private var status : Status = .onShelf
    @State private var title : String = ""
    @State private var author : String = ""
    @State private var summary  = ""
    @State private var genre  = ""
    @State private var dateAdded  = Date.distantPast
    @State private var dateStarted = Date.distantPast
    @State private var dateFinished = Date.distantPast
    @State private var rating : Int? = 5
    @State private var firstAppear : Bool = true
    @State private var recommendedBy : String = ""
    let book : BookModel
   // var changed : Bool = false
    
    var body: some View {
        HStack{
            Text("Status")
            Picker("", selection: $status) {
                ForEach(Status.allCases ){ value in
                    Text(value.descr).tag(value)
                }
            }
            .buttonStyle(.borderedProminent)
            
        }
        VStack(alignment: .leading){
            GroupBox{
                LabeledContent {
                    DatePicker("", selection: $dateAdded,displayedComponents: .date)
                } label: {
                    Text(" Date Added")
                }
                if status == .inProgress{
                    LabeledContent {
                        DatePicker("", selection: $dateStarted,displayedComponents: .date)
                    } label: {
                        Text("Date Started")
                    }
                    if status == .completed{
                        LabeledContent {
                            DatePicker("", selection: $dateFinished,displayedComponents: .date)
                        } label: {
                            Text("Date Finished")
                        }
                    }
                    
                }
                
            }
            .foregroundStyle(.secondary)
            .onChange(of: status) {oldValue, newValue in
               if !firstAppear { if newValue == .onShelf {
                    dateStarted = Date.distantPast
                    dateFinished = Date.distantPast
                } else if newValue == .inProgress && oldValue == . completed {
                    // from completed to inProgress
                    dateFinished = Date.distantPast
                } else if newValue == .inProgress && oldValue == . onShelf {
                    //   BookModel has been started
                    dateStarted = Date.now
                } else if newValue == .completed && oldValue == . onShelf {
                    // Forgot to start book
                    dateFinished = Date.now
                    dateStarted = dateAdded
                } else {
                    // completed
                    dateFinished = Date.now
                    
                }
                   firstAppear = false
                }
                    }
            Divider()
            LabeledContent {
                RatingsView(maxRating: 5, currentRating: $rating, width: 30)
            } label: {
                Text("Rating")
            }
            LabeledContent {
                TextField("", text: $title)
            } label: {
                Text("Title")
            }
            LabeledContent {
                TextField("", text: $author)
            } label: {
                Text("Author")
            }
            LabeledContent {
                TextField("", text: $recommendedBy)
            } label: {
                Text("recommended By")
            }
           Divider()
            Text("Summary").foregroundStyle(.secondary)
            TextEditor(text: $summary)
                .padding(5)
                .overlay {
                    RoundedRectangle(cornerRadius: 20).stroke(Color(uiColor: .tertiarySystemFill),lineWidth: 2)
                }
            NavigationLink {
                QuotesListView(book: book)
            } label: {
                let count = book.quotes?.count ?? 0
                Label( "^[\(count) Quotes](inflect:true)" , systemImage: "quote.opening")
            }
            .buttonStyle(.bordered)
            .frame(maxWidth: .infinity,  alignment: .trailing)
            .padding(.horizontal)

                }
        .padding()
        .textFieldStyle(.roundedBorder)
        .navigationTitle(title)
   //     .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if changed   { // to hide button for the first time
                Button("Update") {
                    //update the book
                    book.author = author
                    book.rating = rating
                    book.status = status.rawValue
                    book.title = title
                    book.summary = summary
                    book.dateAdded = dateAdded
                    book.dateStarted = dateStarted
                    book.dateCompleted = dateFinished
                    book.recommended = recommendedBy
                    
                    dismiss()
                }
                
                .buttonStyle(.borderedProminent)
            }
        }.onAppear{
            status =   Status(rawValue: book.status)! // ?? .onShelf
            rating = book.rating
            title = book.title
            author = book.author
            summary = book.summary
            dateAdded = book.dateAdded
            dateStarted = book.dateStarted
            dateFinished = book.dateCompleted
            recommendedBy = book.recommended ?? ""
        }
        
        
    }
    var changed : Bool {
        status.rawValue !=  book.status
       || rating != book.rating
       || title != book.title
       || author != book.author
       || summary != book.summary
       || dateAdded != book.dateAdded
       || dateStarted != book.dateStarted
       || dateFinished != book.dateCompleted
        || recommendedBy != book.recommended 
    }
        }
        
//        #Preview {
//            EditBook()
//        }
