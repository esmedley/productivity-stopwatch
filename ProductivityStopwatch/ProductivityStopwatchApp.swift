//
//  ProductivityStopwatchApp.swift
//  ProductivityStopwatch
//
//  Created by esmedley on 08/01/2026.
//

import SwiftUI

@main
struct ProductivityStopwatchApp: App {
    @State private var authorized = false
    
    var body: some Scene {
        WindowGroup {
            if authorized {
                ContentView()
            } else {
                AuthorizationView(authorized: $authorized)
            }
        }
    }
}

