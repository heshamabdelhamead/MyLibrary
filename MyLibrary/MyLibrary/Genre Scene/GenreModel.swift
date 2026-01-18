//
//  GenreModel.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 11/01/2026.
//

import SwiftUI
import SwiftData
@Model
class GenreModel {
    var name : String = ""
    var color : String = "ff0000" 
    var books : [BookModel]?
    init(name: String, color: String) {
        self.name = name
        self.color = color
    }
    var hexColor: Color  {
        Color(hex: self.color) ?? .red
    }
}
