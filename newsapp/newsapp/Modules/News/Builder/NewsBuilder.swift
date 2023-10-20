//
//  NewsBuilder.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import UIKit

final class NewsBuilder {
    static func build() -> UINavigationController {
        let controller = NewsViewController()
                
        let loadingManager = LoadingManager.shared

        let alertManager = AlertManager.shared
                
        let newsRepository = NewsRepository.getInstance()
                
        let navigationController = UINavigationController(rootViewController: controller)

        controller.viewModel = NewsViewModel(newsRepository: newsRepository, alertManager: alertManager, loadingManager: loadingManager)

        return navigationController
    }
}
