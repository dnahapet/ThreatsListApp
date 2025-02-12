//
//  ThreatDetailView.swift
//  ThreatsListApp
//
//  Created by Davit Nahapetyan on 2025-02-12.
//

import SwiftUI

struct ThreatDetailView: View {
    let threat: Threat
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("threat: \(threat.threat)")
                .font(.body)
            Text("url_status: \(threat.urlStatus)")
                .font(.body)
            Text("urlhaus_reference: \(threat.urlhausReference)")
                .font(.body)
            Spacer()
        }
        .padding()
        .navigationTitle("Threat Details")
    }
}
