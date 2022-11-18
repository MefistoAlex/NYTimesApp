//
//  FavouritesViewController.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 17.11.2022.
//

import RxCocoa
import RxSwift
import UIKit

final class FavouritesViewController: NewsViewController {
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableBinding()
        refreshTableData()
        erorrHandling()
    }

    // MARK: - Privates

    override func erorrHandling() {
        newsViewModel.favourites.subscribe { event in
            if let error = event.error {
                self.showErrorAlert(with: error)
            }
            self.refreshControl.endRefreshing()
        }.disposed(by: disposeBag)
    }

    override func tableBinding() {
        super.tableBinding()
        newsViewModel.favourites.asDriver(onErrorJustReturn: [Article]())
            .drive(tableView.rx.items(
                cellIdentifier: String(describing: ArticleTableViewCell.self),
                cellType: ArticleTableViewCell.self)) { _, article, cell in
                    cell.setArticle(article)
            }.disposed(by: disposeBag)

        tableView.rx.modelDeleted(Article.self).subscribe { article in
            self.newsViewModel.deleteArticleFromFavourites(article)
        }.disposed(by: disposeBag)
    }

    @objc override func refreshTableData() {
        newsViewModel.getFavouriteNews()
    }
}
