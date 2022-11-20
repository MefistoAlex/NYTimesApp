//
//  ViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 20.11.2022.
//

import Foundation
import RxSwift

class NewsViewModel: ViewModelProtocol {
    private var category: NewsCategory
    private let newsServise: NewsAPIServiceProtocol
    var newsError: Observable<Error> { errorSubject }
    private let errorSubject = PublishSubject<Error>()

    var news: Observable<[Article]> { newsSubject }
    private let newsSubject = BehaviorSubject(value: [Article]())

    init(category: NewsCategory) {
        self.category = category
        newsServise = NewsAPIService()
    }

    func getNews() {
        newsServise.getNewsByCategory(category) { [weak self] articles, error in
            if let error {
                self?.errorSubject.onNext(error)
            }
            if let articles {
                self?.newsSubject.onNext(articles)
            }
        }
    }
}
