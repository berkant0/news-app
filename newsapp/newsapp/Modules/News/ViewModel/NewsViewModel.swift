//
//  NewsViewModel.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import Foundation

protocol NewsViewModelDelegate: AnyObject {
    func successSearchService()
    func failSearchService(error: ApiError)
}

final class NewsViewModel {

    // MARK: Properties
    private let newsRepository: NewsRepositoryProtocol
    private let alertManager: AlertShowable
    private let loadingManager: Loading

    weak var delegate: NewsViewModelDelegate? = nil

    private var responseSearch: SearchResponse = .emptyInstance()

    var news: [Article] {
        return responseSearch.articles ?? []
    }

    // Pagination
    private var maxPage = 5
    private var pageNumber = 1

    init(newsRepository: NewsRepositoryProtocol,
        alertManager: AlertShowable,
        loadingManager: Loading) {
        self.newsRepository = newsRepository
        self.alertManager = alertManager
        self.loadingManager = loadingManager
    }

    func getSearchServiceWithPagination(term: String, completion: @escaping () -> Void) {
        if !isReachLastPagePagination() {
            self.pageNumber += 1
            self.searchService(with: term, page: self.pageNumber)
            completion()
        } else {
            self.pageNumber = 1
            completion()
        }
    }

    func searchService(with term: String, page: Int) {
        loadingManager.show()
        newsRepository.getNews(parameters: .init(searchTerm: term, page: String(page))) { [weak self] response, error in
            guard let self = self else { return }
            loadingManager.hide()
            self.responseSearch = .emptyInstance()
            if let error = error {
                self.alertManager.showAlert(with: error)
            } else if let response = response {
                guard response.totalResults > 0 || response.articles?.count != 0 else {
                    self.delegate?.failSearchService(error: .notFound)
                    return
                }
                
                self.responseSearch = response
                self.delegate?.successSearchService()
            }
        }
    }

    private func isReachLastPagePagination() -> Bool {
        return self.pageNumber >= maxPage
    }
}

// MARK: Helper for News
extension NewsViewModel {

    func newsNumberOfItemsInSection() -> Int {
        return news.count
    }

    func newsCellForItemAt(index: Int) -> Article {
        return news[index]
    }
    
    func newsDidSelectItemAt(indexPath: IndexPath) -> Article {
        return news[indexPath.row]
    }
}
