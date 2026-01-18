//
//  AuthorizationView.swift
//  ProductivityStopwatch
//
//  Created by ec2-user on 11/01/2026.
//

import SwiftUI
import FamilyControls
import DeviceActivity

struct AuthorizationView: View {
    @Binding var authorized: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Screen Time access is required")
                .font(.title2)
            
            Button("Authorize") {
                Task {
                    do {
                        try await AuthorizationCenter.shared.requestAuthorization(for: .individual)
                        authorized = true
                        print("Authorized")
                    } catch {
                        print("Failed to enroll user with err: \(error)")
                        authorized = false
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

//#Preview {
//    AuthorizationView()
//}
