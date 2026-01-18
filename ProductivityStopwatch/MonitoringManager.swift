//
//  MonitoringManager.swift
//  ProductivityStopwatch
//
//  Created by esmedley on 17/01/2026.
//

import Foundation

class MonitoringManager {
    static let shared = MonitoringManager()
    
    private init() {}
    
    private(set) var usage: [String: TimeInterval] = [:]
    
    func updateUsage(for apps: [String: TimeInterval]) {
        for (bundleID, duration) in apps {
            usage[bundleID, default: 0] += duration
        }
        
        let defaults = UserDefaults(suiteName: AppGroup.id)
        defaults?.set(usage, forKey: "usagePerApp")
    }
    
    func loadSavedUsage() {
        let defaults = UserDefaults(suiteName: AppGroup.id)
        usage = defaults?.dictionary(forKey: "usagePerApp") as? [String: TimeInterval] ?? [:]
        
        #if targetEnvironment(simulator)
        if usage.isEmpty {
            usage = [
                "com.apple.Music": 3600,
                "com.apple.Safari": 2400,
                "com.apple.Maps": 1800
            ]
            defaults?.set(usage, forKey: "usagePerApp")
        }
        #endif
    }
}
