//
//  MyBookListApp.swift
//  MyBookList
//
//  Created by Daichi Morihara on 2021/12/03.
//

import SwiftUI

@main
struct MyBookListApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
        
    }
}
