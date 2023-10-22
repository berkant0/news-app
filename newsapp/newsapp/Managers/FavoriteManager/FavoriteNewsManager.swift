//
//  FavoriteNewsManager.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 21.10.2023.
//

import Foundation

class FavoriteNewsManager {

    static let shared = FavoriteNewsManager()
    private let userDefaults = UserDefaults.standard
    private let favoriteNewsKey = "FavoriteNews"

    func addFavoriteNews(news: Article) {
        var favoriteNewsList = getFavoriteNews()
        favoriteNewsList.append(news)

        let encoder = JSONEncoder()
        if let encodedFavoriteNews = try? encoder.encode(favoriteNewsList) {
            userDefaults.set(encodedFavoriteNews, forKey: favoriteNewsKey)
        }
    }
    
    func getFavoriteNews() -> [Article] {
        if let savedFavoriteNews = userDefaults.object(forKey: favoriteNewsKey) as? Data {
            let decoder = JSONDecoder()
            if let decodedFavoriteNews = try? decoder.decode([Article].self, from: savedFavoriteNews) {
                return decodedFavoriteNews
            }
        }
        return []
    }

    func removeFavoriteNews(news: Article) {
        var favoriteNewsList = getFavoriteNews()
        if let index = favoriteNewsList.firstIndex(where: { $0.title == news.title && $0.url == news.url }) {
            favoriteNewsList.remove(at: index)
            let encoder = JSONEncoder()
            if let encodedFavoriteNews = try? encoder.encode(favoriteNewsList) {
                userDefaults.set(encodedFavoriteNews, forKey: favoriteNewsKey)
            }
        }
    }


    func isNewsFavorite(news: Article) -> Bool {
        let favoriteNewsList = getFavoriteNews()
        for favoriteNews in favoriteNewsList {
            if news.title == favoriteNews.title && news.url == favoriteNews.url {
                return true
            }
        }
        return false
    }
}
