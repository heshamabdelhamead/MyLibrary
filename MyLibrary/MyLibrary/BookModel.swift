//
//  Book.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 30/12/2025.
//

import SwiftUI
import SwiftData
@Model
class BookModel{
    var title:String
    var author:String
    var dateAdded:Date
    var  dateStarted : Date
    var dateCompleted:Date
    var summary:String
    var rating: Int?
    var status:Status.RawValue
    var recommended : String?
    @Relationship(deleteRule: .cascade )
    var quotes : [QuoteModel]?
    @Relationship( inverse: \GenreModel.books )
    var genres : [GenreModel]?
    init(
        title: String,
        author: String,
        dateAdded: Date = Date(),
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date=Date.distantPast,
        summary: String="",
        rating: Int? = nil,
        status: Status = .onShelf,
        recommended: String? = nil
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status.rawValue
        self.recommended = recommended
    }
    var icon: Image {
        switch Status(rawValue: status) {
        case .onShelf:
            return Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            return Image(systemName: "book.fill")
        case .completed:
            return Image(systemName: "books.vertical.fill")
        case .none:
            return Image(systemName: "checkmark.diamond.fill")
        }
    }
}
enum Status : Int,Codable, Identifiable,CaseIterable{
    var id : Self {
        self
    }
    case onShelf, inProgress ,completed
    var descr : LocalizedStringResource {
        switch self {
        case .onShelf:
            return "On Shelf"
        case .inProgress:
            return "In Progress"
        case .completed:
            return "Completed"
        }
    }
}
