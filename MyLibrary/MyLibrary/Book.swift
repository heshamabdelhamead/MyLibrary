//
//  Book.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 30/12/2025.
//

import SwiftUI
import SwiftData
@Model
class Book{
    var title:String
    var author:String
    var dateAdded:Date
    var  dateStarted : Date
    var dateCompleted:Date
    var summary:String
    var rating: Int?
    var status:Status
    init(
        title: String,
        author: String,
        dateAdded: Date = Date(),
        dateStarted: Date = Date.distantPast,
        dateCompleted: Date=Date.distantPast,
        summary: String="",
        rating: Int? = nil,
        status: Status = .onShelf
    ) {
        self.title = title
        self.author = author
        self.dateAdded = dateAdded
        self.dateStarted = dateStarted
        self.dateCompleted = dateCompleted
        self.summary = summary
        self.rating = rating
        self.status = status
    }
    var icon: Image {
        switch status {
           case .onShelf:
            return Image(systemName: "checkmark.diamond.fill")
        case .inProgress:
            return Image(systemName: "book.fill")
        case .completed:
            return Image(systemName: "books.vertical.fill")
          
        }
    }
}
enum Status : Int,Codable, Identifiable,CaseIterable{
    var id : Self {
        self
    }
    case onShelf, inProgress ,completed
    var descr : String{
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
