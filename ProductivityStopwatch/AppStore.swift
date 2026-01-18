//
//  AppStore.swift
//  ProductivityStopwatch
//
//  Created by esmedley on 11/01/2026.
//

import SwiftUI

class AppStore: ObservableObject {
    @Published var appUsage: [String: TimeInterval] = [:]
    
    func reload() {
        MonitoringManager.shared.loadSavedUsage()
        appUsage = MonitoringManager.shared.usage
    }
}

//#Preview {
//    AppStore()
//}
