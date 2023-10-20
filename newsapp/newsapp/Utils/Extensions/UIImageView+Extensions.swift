//
//  UIImageView+Extensions.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 20.10.2023.
//

import UIKit
import Kingfisher

extension UIImageView {

    func setImageColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }

    func downloadImage(imageUrl: String?,
                       placeHolderImage: UIImage? = UIImage(named: "not_found_display_image"),
                       downloadedCallback: ((_ isFailed: Bool) -> Void)? = nil) {
        downloadImage(imageUrl: imageUrl,
                      placeHolderImage: placeHolderImage,
                      errorHolderImage: placeHolderImage,
                      downloadedCallback: downloadedCallback)
    }

    func downloadImage(imageUrl: String?,
                       placeHolderImage: UIImage? = UIImage(named: "not_found_display_image"),
                       errorHolderImage: UIImage? = UIImage(named: "not_found_display_image"),
                       downloadedCallback: ((_ isFailed: Bool) -> Void)? = nil) {
        if let imageUrl = imageUrl {
            let url = URL(string: imageUrl)
            self.kf.indicatorType = .activity
            self.kf.setImage(with: url,
                             placeholder: placeHolderImage,
                             options: [.transition(.fade(0.3)), .cacheOriginalImage],
                             progressBlock: nil) { (error) in
                switch error {
                case .success(_):
                    downloadedCallback?(false)
                case .failure(_):
                    self.image = errorHolderImage
                    downloadedCallback?(true)
                }
            }
        } else {
            image = placeHolderImage
        }
    } 
}
