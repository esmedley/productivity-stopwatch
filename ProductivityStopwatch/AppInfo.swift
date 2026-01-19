//
//  AppInfo.swift
//  ProductivityStopwatch
//
//  Created by ec2-user on 18/01/2026.
//

import Foundation

struct AppInfo: Codable, Hashable {
    let bundleID: String
    let displayName: String
    let duration: TimeInterval
}
