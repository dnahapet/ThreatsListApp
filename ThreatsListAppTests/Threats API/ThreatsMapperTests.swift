//
//  ThreatsMapperTests.swift
//  ThreatsListAppTests
//
//  Created by Davit Nahapetyan on 2025-02-11.
//

import XCTest
import ThreatsListApp

class ThreatsMapperTests: XCTestCase {
        
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(try ThreatsMapper.map(json, from: HTTPURLResponse(statusCode: code)))
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() throws {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(try ThreatsMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200)))
    }
    
    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeItemsJSON([])
        
        let result = try ThreatsMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        let item1 = makeItem(
            id: 123,
            threat: "a threat",
            urlStatus: "a status",
            urlhausReference: "a reference")
        
        let item2 = makeItem(
            id: 456,
            threat: "another threat",
            urlStatus: "another status",
            urlhausReference: "another reference")
        
        let json = makeItemsJSON([item1.json, item2.json])
        
        let result = try ThreatsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [item1.model, item2.model])
    }
    
    // MARK: - Helpers
    
    private func makeItem(id: Int, threat: String, urlStatus: String, urlhausReference: String) -> (model: Threat, json: [String: Any]) {
        let item = Threat(id: id, threat: threat, urlStatus: urlStatus, urlhausReference: urlhausReference)
        
        let json = [
            "id": id,
            "threat": threat,
            "url_status": urlStatus,
            "urlhaus_reference": urlhausReference
        ].compactMapValues { $0 }
        
        return (item, json)
    }
}
