//
//  Threat.swift
//  ThreatsListApp
//
//  Created by Davit Nahapetyan on 2025-02-11.
//

import Foundation

public struct Threat: Identifiable, Equatable {
    public let id: Int
    public let threat: String
    public let urlStatus: String
    public let urlhausReference: String

    public init(id: Int, threat: String, urlStatus: String, urlhausReference: String) {
        self.id = id
        self.threat = threat
        self.urlStatus = urlStatus
        self.urlhausReference = urlhausReference
    }
}
