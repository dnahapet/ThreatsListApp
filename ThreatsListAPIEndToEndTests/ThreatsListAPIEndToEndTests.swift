//
//  ThreatsListAPIEndToEndTests.swift
//  ThreatsListAPIEndToEndTests
//
//  Created by Davit Nahapetyan on 2025-02-12.
//

import XCTest
import ThreatsListApp

class ThreatsListAPIEndToEndTests: XCTestCase {
    
    func test_endToEndTestServerGETThreatsResult_success() {
        switch getThreatsResult() {
        case let .success(threats)?:
            XCTAssertTrue(threats.count == 10, "Expected 10 threats, got \(threats.count) instead")
        case let .failure(error)?:
            XCTFail("Expected successful threats result, got \(error) instead")
        default:
            XCTFail("Expected successful threats result, got no result instead")
        }
    }
        
    // MARK: - Helpers
    
    private func getThreatsResult(file: StaticString = #file, line: UInt = #line) -> Swift.Result<[Threat], Error>? {
        let client = ephemeralClient()
        let exp = expectation(description: "Wait for load completion")
        
        var receivedResult: Swift.Result<[Threat], Error>?
        client.get(from: testServerURL) { result in
            receivedResult = result.flatMap { (data, response) in
                do {
                    return .success(try ThreatsMapper.map(data, from: response))
                } catch {
                    return .failure(error)
                }
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5.0)
        
        return receivedResult
    }
        
    private var testServerURL: URL {
        return URL(string: "https://urlhaus-api.abuse.ch/v1/urls/recent/limit/10/")!
    }
    
    private func ephemeralClient(file: StaticString = #file, line: UInt = #line) -> HTTPClient {
        let client = URLSessionHTTPClient(session: URLSession(configuration: .ephemeral))
        trackForMemoryLeaks(client, file: file, line: line)
        return client
    }
}
