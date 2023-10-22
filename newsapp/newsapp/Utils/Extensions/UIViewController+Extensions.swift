//
//  UIViewController+Extensions.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import UIKit

extension UIViewController {

    static func instantiateFromNibOrSelfIntance() -> Self {
        func instantiateFromNibOrSelfIntance<T: UIViewController>(_ viewType: T.Type) -> T {
            guard let _ = Bundle.main.path(forResource: String(describing: T.self), ofType: "nib") else {
                return T.init()
            }
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNibOrSelfIntance(self)
    }

    func visibleTabBar(isVisible: Bool) {
        self.tabBarController?.tabBar.isHidden = !isVisible
    }

    func visibleNavigationBar(isVisible: Bool, animated: Bool = true) {
        self.navigationController?.navigationBar.isHidden = !isVisible
    }
}

extension UIViewController {
    func openWebviewController(pageTitle: String? = nil,
        urlString: String? = nil,
        isModal: Bool = false) {
        let webViewController = WebViewBuilder.generate(pageTitle: pageTitle,
            urlString: urlString,
            isModal: isModal)
        if isModal {
            self.navigationController?.pushViewController(webViewController, animated: true)
        } else {
            self.present(webViewController, animated: true)
        }
    }

    func shareURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)

            // UIActivityViewController'ı göster
            if let presenter = activityViewController.popoverPresentationController {
                // iPad gibi cihazlarda uygun bir konum belirleme
                presenter.sourceView = view
                presenter.sourceRect = view.bounds
            }

            present(activityViewController, animated: true, completion: nil)
        }
    }
}
