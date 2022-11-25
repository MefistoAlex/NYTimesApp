//
//  ArticleTableViewCell.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import SDWebImage
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
            newsImageView.sd_setImage(with: URL(string: imageUrl))
        }
    }

    override func prepareForReuse() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        newsImageView.image = nil
    }
}
