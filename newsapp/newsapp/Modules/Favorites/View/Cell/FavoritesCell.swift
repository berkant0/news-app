//
//  FavoritesCell.swift
//  newsapp
//
//  Created by Berkant Dağtekin on 21.10.2023.
//

import UIKit

class FavoritesCell: UITableViewCell {

    // MARK: IBOutlets
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescriptiopn: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    func configureCell(with model: Article) {
        // Label Title
        labelTitle.text = model.title

        // Label Description
        labelDescriptiopn.text = model.description

        // Image News
        imgNews.downloadImage(imageUrl: model.urlToImage)
    }
}
