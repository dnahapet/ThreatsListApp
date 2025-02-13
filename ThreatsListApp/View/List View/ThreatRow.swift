//
//  ThreatRow.swift
//  ThreatsListApp
//
//  Created by Davit Nahapetyan on 2025-02-12.
//

import SwiftUI

struct ThreatRow: View {
    let threat: Threat
        
    var threatStatusColor: Color {
        switch threat.urlStatus {
        case "online": return .green
        case "offline": return .red
        default: return .orange
        }
    }
    
    var body: some View {
        HStack {
            Circle()
                .fill(threatStatusColor)
                .frame(width: 16, height: 16)
            Spacer()
            VStack(alignment: .leading) {
                Text(threat.threat)
                    .font(.headline)
                Text(threat.urlhausReference)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding()
    }
}
