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
            VStack {
                VStack {
                    Text("Last Scan: \(viewModel.lastScanDate)")
                        .font(.headline)
                    
                    Button(action: viewModel.loadThreats) {
                        Text("Start Scan")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.orange)
                            .cornerRadius(20)
                    }
                    .padding(.horizontal)
                }
                .padding()
                
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
