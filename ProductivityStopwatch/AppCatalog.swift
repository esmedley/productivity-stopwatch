//
//  AppCatalog.swift
//  ProductivityStopwatch
//
//  Created by ec2-user on 18/01/2026.
//

import Foundation

final class AppCatalog {
    
    static func loadApps() -> [AppInfo] {
        let defaults = UserDefaults(suiteName: AppGroup.id)
        guard let data = defaults?.data(forKey: "knownApps") else { return [] }
        return (try? JSONDecoder().decode([AppInfo].self, from: data)) ?? []
    }
    
    static func saveSelection(_ bundleIDs: Set<String>) {
        let defaults = UserDefaults(suiteName: AppGroup.id)
        if let data = try? JSONEncoder().encode(bundleIDs) {
            defaults?.set(data, forKey: "monitoredApps")
        }
    }
    
    static func loadSelection() -> Set<String> {
        let defaults = UserDefaults(suiteName: AppGroup.id)
        if let data = defaults?.data(forKey: "monitoredApps"),
           let saved = try? JSONDecoder().decode(Set<String>.self, from: data) {
            return saved
        }
        return []
    }
}
