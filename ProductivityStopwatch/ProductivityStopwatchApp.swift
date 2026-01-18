//
//  ProductivityStopwatchApp.swift
//  ProductivityStopwatch
//
//  Created by esmedley on 08/01/2026.
//

import SwiftUI

@main
struct ProductivityStopwatchApp: App {
    @StateObject private var store = AppStore()
    @State private var authorized = false
    
    var body: some Scene {
        WindowGroup {
            if authorized {
                ContentView()
                    .environmentObject(store)
                    .onAppear {
                        MonitoringManager.shared.loadSavedUsage()
                        store.reload()
                    }
            } else {
                AuthorizationView(authorized: $authorized)
            }
        }
    }
}

