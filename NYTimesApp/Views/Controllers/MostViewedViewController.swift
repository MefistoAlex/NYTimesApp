//
//  MostViewedViewController.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//
import RxCocoa
import RxSwift
import UIKit

final class MostViewedViewController: NewsViewController {
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableBinding()
        refreshTableData()
        erorrHandling()
    }

    // MARK: - Privates

    override func tableBinding() {
        super.tableBinding()
        newsViewModel.mostViewed.asDriver(onErrorJustReturn: [Article]())
            .drive(tableView.rx.items(
                cellIdentifier: String(describing: ArticleTableViewCell.self),
                cellType: ArticleTableViewCell.self)) { _, article, cell in
                    cell.setArticle(article)
            }.disposed(by: disposeBag)
    }

    @objc override func refreshTableData() {
        newsViewModel.getNewsByCategory(.viewed)
    }
}
