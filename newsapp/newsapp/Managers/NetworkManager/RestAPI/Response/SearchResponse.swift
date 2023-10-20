//
//  SearchResponse.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]?
    
    static func emptyInstance() -> SearchResponse {
        return .init(status: "", totalResults: 0, articles: [])
    }
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    let content: String
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
