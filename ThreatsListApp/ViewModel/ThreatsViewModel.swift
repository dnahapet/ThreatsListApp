//
//  ThreatsViewModel.swift
//  ThreatsListApp
//
//  Created by Davit Nahapetyan on 2025-02-12.
//

import Foundation

class ThreatsViewModel: ObservableObject {
    @Published var threats: [Threat] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var lastScanDate: String = "Not Scanned"
    
    private let httpClient: HTTPClient
    
    private var threatsServerURL: URL {
        return URL(string: "https://urlhaus-api.abuse.ch/v1/urls/recent/limit/10/")!
    }
    
    init(httpClient: HTTPClient = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))) {
        self.httpClient = httpClient
    }
    
    func loadThreats() {
        isLoading = true
        errorMessage = nil
        lastScanDate = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
        
        httpClient.get(from: threatsServerURL) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                do {
                    switch result {
                    case .success(let (data, response)):
                        self?.threats = try ThreatsMapper.map(data, from: response)
                    case .failure(let error):
                        self?.errorMessage = error.localizedDescription
                    }
                } catch {
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
