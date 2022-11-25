//
//  ArticleTableViewCell.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import Kingfisher
import UIKit

final class ArticleTableViewCell: UITableViewCell {
    // MARK: - Outlets

    @IBOutlet private var newsImageView: UIImageView!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var titleLabel: UILabel!

    func setArticle(_ article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        if let imageUrl = article.imageUrl {
            let url = URL(string: imageUrl)
            newsImageView.kf.setImage(with: url)
        }
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImageView.image = nil
    }
}
