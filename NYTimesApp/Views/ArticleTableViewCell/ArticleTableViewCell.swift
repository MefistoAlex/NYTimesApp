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
    @IBOutlet private var titleLabel:
        UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setArticle(_ article: Article) {
        titleLabel.text = article.title
        descriptionLabel.text = article.description
        if let imageUrl = article.imageUrl {
            newsImageView.sd_setImage(with: URL(string: imageUrl))
        }
    }
}
