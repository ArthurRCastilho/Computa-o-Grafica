//
//  triangleApp.swift
//  triangle
//
//  Created by Arthur Rodrigues on 12/11/24.
//

import SwiftUI

@main
struct triangleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 800, height: 600)
        }
    }
}
