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
        newsViewModel = FavouritesNewsViewModel.shared
        tableBinding()
        refreshTableData()
        errorHandling()
    }

    // MARK: - Privates

    override func tableBinding() {
        super.tableBinding()
        tableView.rx.modelDeleted(Article.self).asDriver().drive { article in
            (self.newsViewModel as! FavouritesNewsViewModel).deleteArticleFromFavourites(article)
        }.disposed(by: disposeBag)
    }

}
