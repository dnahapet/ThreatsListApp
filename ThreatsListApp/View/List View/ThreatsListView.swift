//
//  ThreatsListView.swift
//  ThreatsListApp
//
//  Created by Davit Nahapetyan on 2025-02-12.
//

import SwiftUI

struct ThreatsListView: View {
    @StateObject private var viewModel = ThreatsViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Device at high risk!")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text("Last scan - \(viewModel.lastScanDate)")
                        .foregroundColor(.white)
                    Button(action: {
                        viewModel.loadThreats()
                    }) {
                        Text("Start Scan")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                }
                .padding()
                .background(Color.orange)
                .cornerRadius(12)
                
                if viewModel.isLoading {
                    ProgressView("Scanning...")
                }
                else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                        .foregroundColor(.red)
                }
                else {
                    List(viewModel.threats) { threat in
                        NavigationLink(destination: ThreatDetailView(threat: threat)) {
                            ThreatRow(threat: threat)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Threats Scanner").font(.headline)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ThreatsListView_Previews: PreviewProvider {
    static var previews: some View {
        ThreatsListView()
    }
}
