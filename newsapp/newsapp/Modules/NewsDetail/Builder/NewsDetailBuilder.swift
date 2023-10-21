//
//  NewsDetailBuilder.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import UIKit

final class NewsDetailBuilder {
    static func build(item: Article) -> NewsDetailViewController {
        let controller = NewsDetailViewController.instantiateFromNibOrSelfIntance()
        controller.configure(with: item)
        
        return controller
    }
}
