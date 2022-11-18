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
    let newsViewModel = NewsViewModel.shared
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

        tableView.rx.modelSelected(Article.self).subscribe { article in
            self.presetnArticle(article)
        }.disposed(by: disposeBag)

        tableView.rx.itemSelected.bind { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
    }

    func erorrHandling() {}

    @objc func refreshTableData() {}
}
