//
//  ThreatRow.swift
//  ThreatsListApp
//
//  Created by Davit Nahapetyan on 2025-02-12.
//

import SwiftUI

struct ThreatRow: View {
    let threat: Threat
        
    var threatStatus: String {
        switch threat.urlStatus {
        case "online": return "🟢"
        case "offline": return "🔴"
        default: return "🟡"
        }
    }
    
    var body: some View {
        HStack {
            Text(threatStatus)
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
