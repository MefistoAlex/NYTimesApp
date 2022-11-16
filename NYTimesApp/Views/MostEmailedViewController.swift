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
    private let disposeBag = DisposeBag()
    private let newsViewModel = NewsViewModel.shared
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: String(describing: ArticleTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ArticleTableViewCell.self))

        newsViewModel.getNewsByCategory(.emailed)

        newsViewModel.mostEmailed.subscribe { error in
            print(error.debugDescription)
        }.disposed(by: disposeBag)

        newsViewModel.mostEmailed.bind(to:
            tableView.rx.items(
                cellIdentifier: String(describing: ArticleTableViewCell.self),
                cellType: ArticleTableViewCell.self)) { _, article, cell in
            cell.setArticle(article)
        }.disposed(by: disposeBag)
    }
}
