//
//  ViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 20.11.2022.
//

import CoreData
import Foundation
import RxSwift

class NewsViewModel {
    private var category: NewsCategory?
    private let newsServise: NewsAPIServiceProtocol
    private let storedNewsService: StoredNewsServiceProtocol

    var newsError: Observable<Error> { errorSubject }
    private let errorSubject = PublishSubject<Error>()

    var news: Observable<[Article]> { newsSubject }
    private let newsSubject = BehaviorSubject(value: [Article]())

    init(category: NewsCategory?) {
        self.category = category
        newsServise = NewsAPIService()
        storedNewsService = StoredNewsService()
    }

    func getNews() {
        if let category {
            newsServise.getNewsByCategory(category) { [weak self] articles, error in
                if let error {
                    self?.errorSubject.onNext(error)
                }
                if let articles {
                    self?.newsSubject.onNext(articles)
                }
            }
        } else {
            do {
                let articles = try storedNewsService.getFavouriteNews()
                newsSubject.onNext(articles)
            } catch {
                errorSubject.onError(error)
            }
        }
    }

    func addArticleToFavourites(_ article: Article) {
        do {
            try storedNewsService.addArticleToFavourites(article)
            getNews()
        } catch {
            errorSubject.onError(error)
        }
    }

    func deleteArticleFromFavourites(_ article: Article) {
        do {
            try storedNewsService.deleteArticleFromFavourites(article)
            getNews()
        } catch {
            errorSubject.onError(error)
        }
    }

    func isFavourite(article: Article) -> Bool {
        var isFavourite: Bool = false
        let favouritesArticles = try? newsSubject.value()
        if let favouritesArticles {
            let set = Set(favouritesArticles)
            isFavourite = set.contains(article)
        }
        return isFavourite
    }
}
