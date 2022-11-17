//
//  ArticleViewController.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 17.11.2022.
//

import UIKit
import WebKit

final class ArticleViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private var favouriteButton: UIBarButtonItem!
    @IBOutlet private var webWiew: WKWebView!

    // MARK: - Properties

    private var article: Article?

    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let article {
            let url = URL(string: article.url)
            let urlRequest = URLRequest(url: url!)
            webWiew.load(urlRequest)
        }
    }

    // MARK: - Actions

    @IBAction func backButtonDidTap(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }

    @IBAction private func favouriteButtonDidTap(_ sender: UIBarButtonItem) {
    }

    func setArticle(_ article: Article) {
        self.article = article
    }
}
