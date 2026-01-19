//
//  ContentView.swift
//  ProductivityStopwatch
//
//  Created by esmedley on 08/01/2026.
//

import SwiftUI
import DeviceActivity
import FamilyControls

struct ContentView: View {
    @State private var allApps: [AppInfo] = []
    @State private var selectedApps: Set<String> = []
    @State private var searchText: String = ""
    
    private let selectedAppsKey = "selectedApps"
    
    var filteredApps: [AppInfo] {
        if searchText.isEmpty {
            return allApps
        }
        return allApps.filter {
            $0.displayName.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("Select apps to monitor")
                    .font(.headline)
                Spacer()
                Button("Refresh Apps") {
                    loadApps()
                }
            }
            .padding(.horizontal)
            .padding(.top)
            
            NavigationStack {
                List(filteredApps.sorted(by: { $0.duration > $1.duration }), id: \.bundleID) { app in
                    HStack {
                        Button {
                            toggleSelection(app.bundleID)
                        } label: {
                            Image(systemName: selectedApps.contains(app.bundleID)
                                  ? "checkmark.square"
                                  : "square")
                        }
                        .buttonStyle(.borderless)
                        
                        VStack(alignment: .leading) {
                            Text(app.displayName)
                                .font(.subheadline)
                            Text("Usage: \(Int(app.duration/60)) min")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                    }
                }
                .searchable(text: $searchText, prompt: "Find apps")
            }
            
            Button("Enable Tracking") {
                Task {
                    do {
                        try await MonitoringManager.shared.requestAuthorization()
                    } catch {
                        print("Authorization failed: \(error)")
                    }
                }
            }
            .padding()
        }
        .onAppear {
            loadApps()
        }
    }
    
    private func loadApps() {
        #if targetEnvironment(simulator)
        allApps = [
            AppInfo(bundleID: "com.apple.Music", displayName: "Music", duration: 1200),
            AppInfo(bundleID: "com.apple.Safari", displayName: "Safari", duration: 3600),
            AppInfo(bundleID: "com.apple.Maps", displayName: "Maps", duration: 2400)
        ]
        selectedApps = Set(allApps.map { $0.bundleID })
        #else
        allApps = AppCatalog.loadApps()
        selectedApps = AppCatalog.loadSelection()
        #endif
    }
    
    private func toggleSelection(_ bundleID: String) {
        if selectedApps.contains(bundleID) {
            selectedApps.remove(bundleID)
        } else {
            selectedApps.insert(bundleID)
        }
        #if !targetEnvironment(simulator)
        AppCatalog.saveSelection(selectedApps)
        #endif
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
