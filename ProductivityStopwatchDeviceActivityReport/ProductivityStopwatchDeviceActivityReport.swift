//
//  ProductivityStopwatchDeviceActivityReport.swift
//  ProductivityStopwatchDeviceActivityReport
//
//  Created by ec2-user on 17/01/2026.
//

import DeviceActivity
import SwiftUI

@main
struct ProductivityStopwatchDeviceActivityReport: DeviceActivityReportExtension {
    var body: some DeviceActivityReportScene {
        // Create a report for each DeviceActivityReport.Context that your app supports.
        TotalActivityReport { results in
            TotalActivityView(results: results)
        }
        // Add more reports here...
    }
}
