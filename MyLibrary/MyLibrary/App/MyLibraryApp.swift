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
    let container : ModelContainer
    var body: some Scene {
        WindowGroup {
            BookListView()
        }.modelContainer(container)
    }
    init () {
        let schema = Schema([BookModel.self])
        let config = ModelConfiguration("MyBooks",schema: schema)
        do {
            container = try ModelContainer(for: schema , configurations : config)
        }
        catch{
            fatalError("can't create model container")
        }
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        
    }
}
