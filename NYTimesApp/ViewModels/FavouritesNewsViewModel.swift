//
//  FavouritesNewsViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 21.11.2022.
//

import CoreData
import Foundation
import RxSwift
class FavouritesNewsViewModel: ViewModelProtocol {
    static let shared = FavouritesNewsViewModel()

    private let storedNewsService: StoredNewsServiceProtocol

    var newsError: Observable<Error> { errorSubject }
    private let errorSubject = PublishSubject<Error>()

    var news: Observable<[Article]> { newsSubject }
    private let newsSubject = BehaviorSubject(value: [Article]())

    private init() {
        storedNewsService = StoredNewsService()
    }

    func getNews() {
        do {
            let articles = try storedNewsService.getFavouriteNews()
            newsSubject.onNext(articles)
        } catch {
            errorSubject.onError(error)
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
