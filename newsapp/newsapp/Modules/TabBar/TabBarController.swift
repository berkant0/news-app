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

        let newsViewController = NewsViewController()
        newsViewController.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 0)

        viewControllers = [newsViewController]
    }
}
