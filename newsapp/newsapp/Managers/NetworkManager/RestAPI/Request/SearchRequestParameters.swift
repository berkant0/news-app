//
//  SearchRequestParameters.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import Foundation

// MARK: SearchRequestParameters
struct SearchRequestParameters: Codable {
    let searchTerm: String
    let page: String
}
