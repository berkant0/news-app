//
//  ApiError.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import Foundation

/// Custom `Error` for Network Manager fail cases
enum ApiError: Error {
    
    case unknownError
    case connectionError
    case notFound
    case serverError
    case timeOut
    case badRequest
    case commonError
}

// MARK: - Helpers
extension ApiError: CustomStringConvertible {
    /// For each error type return the appropriate description
    public var description: String {
        switch self {
        case .connectionError:
            return "Please make sure you are connected to the internet and try again."
        case .notFound:
            return "The media you were looking for was not found. Try looking for something else."
        case .serverError:
            return "There is a problem with the server. Please try again."
        case .timeOut:
            return "Request timed out."
        case .unknownError:
            return "Something went wrong. Please try again."
        case .badRequest:
            return "Bad request. Please try again."
        case .commonError:
            return "An unexpected error occurred while processing your request. Please try again later."
        }
    }
}
