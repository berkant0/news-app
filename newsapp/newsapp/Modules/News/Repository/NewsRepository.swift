//
//  NewsRepository.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import Moya

protocol NewsRepositoryProtocol {

    func getNews(
        parameters: SearchRequestParameters,
        callback: @escaping APIResponseCallback<SearchResponse>
    )
}

final class NewsRepository: BaseRepository<NewsService, MoyaProvider<NewsService>>, NewsRepositoryProtocol {

    init(moyaProvider: MoyaProvider<NewsService>) {
        super.init(provider: moyaProvider)
    }

    func getNews(parameters: SearchRequestParameters,callback: @escaping APIResponseCallback<SearchResponse>) {
        mRequest(.search(parameters), callback: callback)
    }
}

extension NewsRepository {

    static func getInstance() -> NewsRepository {
        return NewsRepository(moyaProvider: createMoyaProvider(targetType: NewsService.self))
    }
}
