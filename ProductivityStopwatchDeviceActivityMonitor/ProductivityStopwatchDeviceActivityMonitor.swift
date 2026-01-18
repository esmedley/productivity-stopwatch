//
//  ProductivityStopwatchDeviceActivityMonitor.swift
//  ProductivityStopwatchDeviceActivityMonitor
//
//  Created by ec2-user on 17/01/2026.
//

import Foundation
import DeviceActivity

final class ProductivityStopwatchDeviceActivityMonitor: DeviceActivityMonitorExtension {
    override func intervalDidEnd(for activity: DeviceActivityName) {
        let appsUsage: [String: TimeInterval] = fetchAppUsage()
        MonitoringManager.shared.updateUsage(for: appsUsage)
    }
    
    private func fetchAppUsage() -> [String: TimeInterval] {
        return [
            "com.apple.Music": 120,
            "com.apple.Safari": 240
        ]
    }
}
