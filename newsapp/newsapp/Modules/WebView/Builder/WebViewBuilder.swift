//
//  WebViewBuilder.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import Foundation

enum WebViewBuilder {
     
    static func generate(pageTitle: String? = nil,
                         urlString: String? = nil,
                         isModal: Bool = false) -> WebViewController {
        let controller = WebViewController.instantiateFromNibOrSelfIntance()
        controller.urlString = urlString
        controller.pageTitle = pageTitle
        return controller
    }
}
