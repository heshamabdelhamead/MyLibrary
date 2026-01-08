//
//  SortTypeEnum.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 06/01/2026.
//

import Foundation
enum SortTypeEnum : String, Identifiable, CaseIterable {
    case title, author, status
    var id: Self { self }
}
