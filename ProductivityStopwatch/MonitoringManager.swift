//
//  MonitoringManager.swift
//  ProductivityStopwatch
//
//  Created by esmedley on 17/01/2026.
//

import Foundation
import FamilyControls
import DeviceActivity

class MonitoringManager {
    static let shared = MonitoringManager()
    
    private init() {}
    
    func requestAuthorization() async throws {
        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
    }
}
