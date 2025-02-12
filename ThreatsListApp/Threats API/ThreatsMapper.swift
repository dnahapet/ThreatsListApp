//
//  ThreatsMapper.swift
//  ThreatsListApp
//
//  Created by Davit Nahapetyan on 2025-02-11.
//

import Foundation

public final class ThreatsMapper {
    private struct Root: Decodable {
        private struct RemoteThreat: Decodable {
            let id: Int
            let threat: String
            let urlStatus: String
            let urlhausReference: String
            
            enum CodingKeys: String, CodingKey {
                case id, threat
                case urlStatus = "url_status"
                case urlhausReference = "urlhaus_reference"
            }
        }

        private let urls: [RemoteThreat]
        
        var threatURLs: [Threat] {
            return urls.map { Threat(id: $0.id, threat: $0.threat, urlStatus: $0.urlStatus, urlhausReference: $0.urlhausReference) }
        }
    }
    
    public enum Error: Swift.Error {
        case invalidData
    }

    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Threat] {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        return root.threatURLs
    }
}
