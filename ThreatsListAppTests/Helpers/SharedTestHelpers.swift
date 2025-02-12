//
//  SharedTestHelpers.swift
//  ThreatsListAppTests
//
//  Created by Davit Nahapetyan on 2025-02-11.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "Any Error", code: 1, userInfo: nil)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func anyData() -> Data {
    return Data("any data".utf8)
}

func makeItemsJSON(_ urls: [[String: Any]]) -> Data {
    let json = ["urls": urls]
    return try! JSONSerialization.data(withJSONObject: json)
}

extension HTTPURLResponse {
    convenience init (statusCode: Int) {
        self.init(url: anyURL(), statusCode: statusCode, httpVersion: nil, headerFields: nil)!
    }
}
