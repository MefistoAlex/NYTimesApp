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
        newsViewModel = MostViewedViewModel()
        tableBinding()
        refreshTableData()
        errorHandling()
    }
}
