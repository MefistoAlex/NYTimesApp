//
//  MostEmailedViewController.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import RxCocoa
import RxSwift
import UIKit

final class MostEmailedViewController: NewsViewController {
    // MARK: - Lyfecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel = NewsViewModel(category: .emailed)
        tableBinding()
        refreshTableData()
        errorHandling()
    }
}
