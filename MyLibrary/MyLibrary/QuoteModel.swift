//
//  QuoteModel.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 09/01/2026.
//

import Foundation
import SwiftData
@Model
class QuoteModel {
    var createdDate =  Date.now
    var text: String
    var page: String?
    init(text: String, page: String? = nil) {
        self.text = text
        self.page = page
    }
    
    var book: BookModel? 
    
}
