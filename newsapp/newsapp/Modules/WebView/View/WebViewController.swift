//
//  WebViewController.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!

    var pageTitle: String? = nil
    var urlString: String? = nil

    override func viewDidLoad() {
        setupWebview()

        self.navigationItem.title = pageTitle
        
        if let urlString = urlString,
            let url = URL(string: urlString) {
            self.webView.load(URLRequest(url: url))
        }
    }

    func setupWebview() {
        self.webView.scrollView.showsVerticalScrollIndicator = false
        self.webView.scrollView.showsHorizontalScrollIndicator = false
        self.webView.scrollView.alwaysBounceVertical = false
        self.webView.scrollView.alwaysBounceHorizontal = false
        self.webView.scrollView.bounces = false
        self.webView.isOpaque = false
        self.webView.scrollView.contentInsetAdjustmentBehavior = .never
    }
}
