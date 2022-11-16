//
//  NewsViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import Foundation
import RxSwift
final class NewsViewModel {
    private let newsServise: NewsAPIServiceProtocol

    static let shared = NewsViewModel()

    var mostEmailed = PublishSubject<[Article]>()
    var mostShared = PublishSubject<[Article]>()
    var mostViewed = PublishSubject<[Article]>()
    var favorites = PublishSubject<[Article]>()

    private init() {
        newsServise = NewsAPIService()
    }

    func getNewsByCategory(_ category: NewsCathegory) {
        newsServise.getNewsByCategory(category) { articles, error in
            if let articles {
                switch category {
                case .emailed:
                    self.mostEmailed.onNext(articles)
                case .shared:
                    self.mostShared.onNext(articles)
                case .viewed:
                    self.mostViewed.onNext(articles)
                }
            } else {
                switch category {
                case .emailed:
                    self.mostEmailed.onError(error!)
                case .shared:
                    self.mostShared.onError(error!)
                case .viewed:
                    self.mostViewed.onError(error!)
                }
            }
            
        }
    }
}
