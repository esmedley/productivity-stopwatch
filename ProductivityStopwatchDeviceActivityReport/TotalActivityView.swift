//
//  TotalActivityView.swift
//  ProductivityStopwatchDeviceActivityReport
//
//  Created by ec2-user on 17/01/2026.
//

import SwiftUI
import DeviceActivity

struct TotalActivityView: View {  
    let results: [AppInfo]
    
    var body: some View {
        VStack {
            Text("App Usage Report")
                .font(.headline)
                .padding()
            
            List(results.sorted(by: { $0.duration > $1.duration }), id: \.bundleID) { app in
                HStack {
                    VStack(alignment: .leading) {
                        Text(app.displayName)
                            .font(.subheadline)
                        Text("Usage: \(Int(app.duration/60)) min")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                Spacer()
            }
        }
    }
}

// In order to support previews for your extension's custom views, make sure its source files are
// members of your app's Xcode target as well as members of your extension's target. You can use
// Xcode's File Inspector to modify a file's Target Membership.
//#Preview {
//    TotalActivityView(totalActivity: "1h 23m")
//}
