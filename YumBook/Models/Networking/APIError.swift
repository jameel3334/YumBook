//
//  APIError.swift
//  YumBook
//
//  Created by Mohammed Jameeluddin on 3/5/23.
//

import SwiftUI

enum NetworkingError: LocalizedError {
    case invalidUrl
    case custom(error: Error)
    case invalidStatusCode(statusCode: Int)
    case invalidData
    case failedToDecode(error: Error)
}

extension NetworkingError: Equatable {
    
    static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidUrl, .invalidUrl):
            return true
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case (.invalidData, .invalidData):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}
