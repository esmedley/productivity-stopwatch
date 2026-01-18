//
//  TotalActivityView.swift
//  ProductivityStopwatchDeviceActivityReport
//
//  Created by ec2-user on 17/01/2026.
//

import SwiftUI
import DeviceActivity

struct TotalActivityView: View {
    @State private var appUsage: [String: TimeInterval] = [:]
    
    var body: some View {
        VStack {
            ForEach(appUsage.sorted(by: { $0.key < $1.key }), id: \.key) { bundleID, duration in
                HStack {
                    Text(bundleID)
                    Spacer()
                    Text("\(Int(duration)/60) min")
                }
            }
        }
        .onAppear(perform: loadFromAppGroup)
        .padding()
    }
    
    func loadFromAppGroup() {
        let defaults = UserDefaults(suiteName: AppGroup.id)
        appUsage = defaults?.dictionary(forKey: "usagePerApp") as? [String: TimeInterval] ?? [:]
    }
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
//#Preview {
//    TotalActivityView(totalActivity: "1h 23m")
//}
