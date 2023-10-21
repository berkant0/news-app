//
//  NewsDetailViewController.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import UIKit

class NewsDetailViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var newsTitlelabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsAuthorLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!

    private var itemUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Detail"
        self.visibleTabBar(isVisible: false)
    }

    func configure(with item: Article) {
        /// Since IBOutlets cannot be lazy, they are not ready when the configure method runs, so dispatch has been added.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.thumbnailImageView.downloadImage(imageUrl: item.urlToImage)
            self.newsTitlelabel.text = item.title
            self.newsDescriptionLabel.text = item.description
            self.newsAuthorLabel.text = item.author
            self.releaseDateLabel.text = item.publishedAt.formatIsoStringToReadableDate()
            self.itemUrl = item.url
        }
    }
    
    @IBAction func openNewsSource() {
        openWebviewController(pageTitle: "News Source", urlString: itemUrl, isModal: true)
    }
}
