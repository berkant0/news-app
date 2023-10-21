//
//  TabBarController.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let newsBuilder = NewsBuilder.build()
        newsBuilder.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 0)

        let favoritesBuilder = FavoritesBuilder.build()
        favoritesBuilder.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        
        viewControllers = [newsBuilder, favoritesBuilder]

    }
}
