//
//  TotalActivityReport.swift
//  ProductivityStopwatchDeviceActivityReport
//
//  Created by ec2-user on 17/01/2026.
//

import DeviceActivity
import SwiftUI

extension DeviceActivityReport.Context {
    // If your app initializes a DeviceActivityReport with this context, then the system will use
    // your extension's corresponding DeviceActivityReportScene to render the contents of the
    // report.
    static let totalActivity = Self("Total Activity")
}

struct TotalActivityReport: DeviceActivityReportScene {
    // Define which context your scene will represent.
    let context: DeviceActivityReport.Context = .totalActivity
    
    // Define the custom configuration and the resulting view for this report.
    let content: ([AppInfo]) -> TotalActivityView
    
    func makeConfiguration(representing data: DeviceActivityResults<DeviceActivityData>) async -> [AppInfo] {
        var appInfo: [AppInfo] = []
        
        #if targetEnvironment(simulator)
        appInfo = [
            AppInfo(bundleID: "com.apple.Music", displayName: "Music", duration: 1200),
            AppInfo(bundleID: "com.apple.Safari", displayName: "Safari", duration: 3600),
            AppInfo(bundleID: "com.apple.Maps", displayName: "Maps", duration: 2400)
        ]
        #else
        for await day in data {
            for await segment in day.activitySegments {
                for await category in segment.categories {
                    for await app in category.applications {
                        let info = AppInfo(
                            bundleID: app.application.bundleIdentifier ?? "No bundle ID",
                            displayName: (app.application.localizedDisplayName ?? app.application.bundleIdentifier) ?? "No display name",
                            duration: app.totalActivityDuration
                        )
                        appInfo.append(info)
                    }
                }
            }
        }
        #endif
        
        return appInfo
    }
}
