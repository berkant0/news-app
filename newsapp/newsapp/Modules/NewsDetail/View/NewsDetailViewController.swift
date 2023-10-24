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
    
    lazy var favoriteButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "heart")?.withRenderingMode(.alwaysOriginal) ?? UIImage(), style: .plain, target: self, action: #selector(favoriteButtonTapped))
    }()
    
    lazy var shareButton: UIBarButtonItem = {
        return UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up")?.withRenderingMode(.alwaysOriginal) ?? UIImage(), style: .plain, target: self, action: #selector(shareButtonTapped))
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationItems()
        
        self.visibleTabBar(isVisible: false)
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "Detail"
                
        navigationItem.rightBarButtonItems = [favoriteButton,shareButton]
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
            self.favoriteButton.image = isSaved ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
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
                favoriteButton.image = UIImage(systemName: "heart")
            } else {
                FavoriteNewsManager.shared.addFavoriteNews(news: news)
                favoriteButton.image = UIImage(systemName: "heart.fill")
            }
        }
    }
}
