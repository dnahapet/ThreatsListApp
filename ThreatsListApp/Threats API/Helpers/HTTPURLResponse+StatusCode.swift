//
//  HTTPURLResponse+StatusCode.swift
//  ThreatsListApp
//
//  Created by Davit Nahapetyan on 2025-02-11.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
