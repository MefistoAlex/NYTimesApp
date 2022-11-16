//
//  MostViewedViewController.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//
import RxCocoa
import RxSwift
import UIKit

final class MostViewedViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let newsViewModel = NewsViewModel.shared

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: String(describing: ArticleTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ArticleTableViewCell.self))

        newsViewModel.getNewsByCategory(.viewed)

        newsViewModel.mostViewed.subscribe { event in
            if let error = event.error {
                self.showErrorAlert(with: error)
            }
        }.disposed(by: disposeBag)

        newsViewModel.mostViewed.asDriver(onErrorJustReturn: [Article]())
            .drive(tableView.rx.items(
                cellIdentifier: String(describing: ArticleTableViewCell.self),
                cellType: ArticleTableViewCell.self)) { _, article, cell in
                    cell.setArticle(article)
            }.disposed(by: disposeBag)
    }
}
