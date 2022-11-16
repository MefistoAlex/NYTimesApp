//
//  MostSharedViewController.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//
import RxCocoa
import RxSwift
import UIKit

final class MostSharedViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let newsViewModel = NewsViewModel.shared

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: String(describing: ArticleTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ArticleTableViewCell.self))

        newsViewModel.getNewsByCategory(.shared)

        newsViewModel.mostShared.subscribe { event in
            if let error = event.error {
                self.showErrorAlert(with: error)
            }
        }.disposed(by: disposeBag)

        newsViewModel.mostShared.asDriver(onErrorJustReturn: [Article]())
            .drive(tableView.rx.items(
                cellIdentifier: String(describing: ArticleTableViewCell.self),
                cellType: ArticleTableViewCell.self)) { _, article, cell in
                    cell.setArticle(article)
            }.disposed(by: disposeBag)
    }
}
