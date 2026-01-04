//
//  MyLibraryApp.swift
//  MyLibrary
//
//  Created by hesham abd elhamead on 30/12/2025.
//

import SwiftUI
import SwiftData

@main
struct MyLibraryApp: App {
    var body: some Scene {
        WindowGroup {
            BookListView()
        }.modelContainer(for:Book.self)
    }
    init () {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
