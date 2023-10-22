//
//  NewsService.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import Moya

enum NewsService {
    case search(SearchRequestParameters)
}

extension NewsService: MTargetType {

    var path: String {
        switch self {
        case .search:
            return Constants.API.search
        }
    }

    var method: MoyaMethod {
        return .get
    }

    var task: MoyaTask {
        switch self {
        case .search(let parameters):
            let requestParameters: [String: String] = [
                "q": parameters.searchTerm,
                "page": String(parameters.page),
            ]
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.queryString)
        }
    }
}

