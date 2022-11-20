//
//  ArticleViewController.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 17.11.2022.
//

import RxSwift
import UIKit
import WebKit

final class ArticleViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private var favouriteButton: UIBarButtonItem!
    @IBOutlet private var webWiew: WKWebView!

    // MARK: - Properties

    private let newsViewModel = FavouritesNewsViewModel.shared
    private let disposeBag = DisposeBag()
    private var article: Article?
    private var isFavourite = false {
        didSet {
            if isFavourite {
                favouriteButton.image = UIImage(systemName: "star.fill")
            } else {
                favouriteButton.image = UIImage(systemName: "star")
            }
        }
    }

    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        if let article {
            let url = URL(string: article.url)
            let urlRequest = URLRequest(url: url!)
            //webWiew.load() in X-Code 14 generate purple issue, than havent solve yet
            webWiew.load(urlRequest)
            isFavourite = newsViewModel.isFavourite(article: article)
        }
    }

    // MARK: - Actions

    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @IBAction private func favouriteButtonDidTap(_ sender: UIBarButtonItem) {
        if let article {
            if isFavourite {
                newsViewModel.deleteArticleFromFavourites(article)
            } else {
                newsViewModel.addArticleToFavourites(article)
            }
            isFavourite = !isFavourite
        }
    }

    func setArticle(_ article: Article) {
        self.article = article
    }
}
