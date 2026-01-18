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
    @EnvironmentObject var store: AppStore
    
    @State private var selectedApps: Set<String> = []
    
    private let selectedAppsKey = "selectedApps"
    
    var body: some View {
        List(store.appUsage.sorted(by: { $0.value > $1.value }), id: \.key) { bundleID, duration in
            HStack {
                Button(action: {
                    toggleSelection(for: bundleID)
                }) {
                    Image(systemName: selectedApps.contains(bundleID) ? "checkmark.square" : "square")
                        .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                }
                .buttonStyle(PlainButtonStyle())
                
                VStack(alignment: .leading) {
                    Text(bundleID).font(.body)
                    Text("\(Int(duration / 60)) min")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
            .padding(.vertical, 4)
        }
        .onAppear {
            store.reload()
            loadSelectedApps()
        }
        .navigationTitle("App Usage")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Print Selected") {
                    print("Selected apps: \(selectedApps)")
                }
            }
        }
    }
    
    private func toggleSelection(for bundleID: String) {
        if selectedApps.contains(bundleID) {
            selectedApps.remove(bundleID)
        } else {
            selectedApps.insert(bundleID)
        }
        saveSelectedApps()
    }
    
    private func loadSelectedApps() {
        let defaults = UserDefaults(suiteName: AppGroup.id)
        if let saved = defaults?.array(forKey: selectedAppsKey) as? [String] {
            selectedApps = Set(saved)
        }
    }
    
    private func saveSelectedApps() {
        let defaults = UserDefaults(suiteName: AppGroup.id)
        defaults?.set(Array(selectedApps), forKey: selectedAppsKey)
    }
}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
