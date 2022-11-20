//
//  BaseViewController.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 18.11.2022.
//

import RxCocoa
import RxSwift
import UIKit

class NewsViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet var tableView: UITableView!

    // MARK: - Properties

    let disposeBag = DisposeBag()
    var newsViewModel: ViewModelProtocol?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.accessibilityViewIsModal = true
        refreshControl.addTarget(self, action: #selector(self.refreshTableData), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - Funcs

    func tableBinding() {
        tableView.addSubview(refreshControl)
        tableView.register(
            UINib(nibName: String(describing: ArticleTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: ArticleTableViewCell.self)
        )

        newsViewModel?.news.asDriver(onErrorJustReturn: [Article]())
            .drive(tableView.rx.items(
                cellIdentifier: String(describing: ArticleTableViewCell.self),
                cellType: ArticleTableViewCell.self)) { _, article, cell in
                    cell.setArticle(article)
            }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Article.self).asDriver().drive { article in
            self.presetnArticle(article)
        }.disposed(by: disposeBag)

        tableView.rx.itemSelected.asDriver().drive { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)

        newsViewModel?.news.subscribe { _ in
            self.refreshControl.endRefreshing()
        }.disposed(by: disposeBag)
    }

    func errorHandling() {
        newsViewModel?.newsError.subscribe { error in
            self.showErrorAlert(with: error)
            self.refreshControl.endRefreshing()
        }.disposed(by: disposeBag)
    }

    @objc func refreshTableData() {
        newsViewModel?.getNews()
    }
}
