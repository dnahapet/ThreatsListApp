//
//  XCTestCase+MemoryLeakTracking.swift
//  ThreatsListAppTests
//
//  Created by Davit Nahapetyan on 2025-02-11.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
