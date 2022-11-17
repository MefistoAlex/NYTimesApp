//
//  MostEmailedViewController.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import RxCocoa
import RxSwift
import UIKit

final class MostEmailedViewController: UIViewController {
    // MARK: - Outlets

    @IBOutlet private var tableView: UITableView!

    // MARK: - Properties

    private let disposeBag = DisposeBag()
    private let newsViewModel = NewsViewModel.shared
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.accessibilityViewIsModal = true
        refreshControl.addTarget(self, action: #selector(self.refreshTableData), for: .valueChanged)
        return refreshControl
    }()

    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableBinding()

        refreshTableData()

        erorrHandling()
    }

    // MARK: - Privates

    private func erorrHandling() {
        newsViewModel.mostEmailed.subscribe { event in
            if let error = event.error {
                self.showErrorAlert(with: error)
            }
            self.refreshControl.endRefreshing()
        }.disposed(by: disposeBag)
    }

    private func tableBinding() {
        tableView.addSubview(refreshControl)

        tableView.register(
            UINib(nibName: String(describing: ArticleTableViewCell.self), bundle: nil),
            forCellReuseIdentifier: String(describing: ArticleTableViewCell.self)
        )

        newsViewModel.mostEmailed.asDriver(onErrorJustReturn: [Article]())
            .drive(tableView.rx.items(
                cellIdentifier: String(describing: ArticleTableViewCell.self),
                cellType: ArticleTableViewCell.self)) { _, article, cell in
                    cell.setArticle(article)
            }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Article.self).subscribe { article in
            self.presetnArticle(article)
        }.disposed(by: disposeBag)

        tableView.rx.itemSelected.bind { indexPath in
            self.tableView.deselectRow(at: indexPath, animated: true)
        }.disposed(by: disposeBag)
    }

    @objc private func refreshTableData() {
        newsViewModel.getNewsByCategory(.emailed)
    }

    private func presetnArticle(_ article: Article) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ArticleViewController.self)) as! ArticleViewController
        controller.setArticle(article)
        let navigationControler = UINavigationController(rootViewController: controller)
        navigationControler.modalPresentationStyle = .fullScreen
        present(navigationControler, animated: true)
    }
}
