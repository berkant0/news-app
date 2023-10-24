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

    var news: Article?
    
    private let favoriteButton = UIButton(type: .custom)
    private let shareButton = UIButton(type: .custom)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        
        self.visibleTabBar(isVisible: false)
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Detail"
        
        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)

        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        
        let shareBarButton = UIBarButtonItem(customView: shareButton)
        let favoriteBarButton = UIBarButtonItem(customView: favoriteButton)
        
        navigationItem.rightBarButtonItems = [favoriteBarButton,shareBarButton]
    }

    func configure(with item: Article) {
        /// Since IBOutlets cannot be lazy, they are not ready when the configure method runs, so dispatch has been added.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.thumbnailImageView.downloadImage(imageUrl: item.urlToImage)
            self.newsTitlelabel.text = item.title
            self.newsDescriptionLabel.text = item.description
            self.newsAuthorLabel.text = item.author
            self.releaseDateLabel.text = item.publishedAt?.formatIsoStringToReadableDate()
            
            let isSaved = FavoriteNewsManager.shared.isNewsFavorite(news: item)
            self.favoriteButton.setImage(isSaved ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
        }
    }

    @IBAction func openNewsSource() {
        openWebviewController(pageTitle: "News Source", urlString: news?.url, isModal: true)
    }
    
    @objc func shareButtonTapped() {
        shareURL(news?.url ?? "")
    }

    @objc func favoriteButtonTapped() {
        if let news = news {
            let isSaved = FavoriteNewsManager.shared.isNewsFavorite(news: news)
            if isSaved {
                FavoriteNewsManager.shared.removeFavoriteNews(news: news)
                favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            } else {
                FavoriteNewsManager.shared.addFavoriteNews(news: news)
                favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }
}
