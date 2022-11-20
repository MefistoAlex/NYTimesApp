//
//  NewsViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import CoreData
import Foundation
import RxSwift

final class NewsViewModel {
    private let newsServise: NewsAPIServiceProtocol
    private let storedNewsService: StoredNewsServiceProtocol
    
    static let shared = NewsViewModel()

    var newsError: Observable<Error> { errorSubject }
    private var errorSubject = PublishSubject<Error>()

    var mostEmailed: Observable<[Article]> { mostEmailedSubject }
    private var mostEmailedSubject = PublishSubject<[Article]>()

    var mostShared: Observable<[Article]> { mostSharedSubject }
    private var mostSharedSubject = PublishSubject<[Article]>()

    var mostViewed: Observable<[Article]> { mostViewedSubject }
    private var mostViewedSubject = PublishSubject<[Article]>()

    var favourites: Observable<[Article]> { favouritesSubject }
    private var favouritesSubject = BehaviorSubject(value: [Article]())

    private init() {
        newsServise = NewsAPIService()
        storedNewsService = StoredNewsService()
    }

   
    func getNewsByCategory(_ category: NewsCategory) {
        newsServise.getNewsByCategory(category) { [weak self] articles, error in
            if let error {
                self?.errorSubject.onNext(error)
            }
            if let articles {
                switch category {
                case .emailed:
                    self?.mostEmailedSubject.onNext(articles)
                case .shared:
                    self?.mostSharedSubject.onNext(articles)
                case .viewed:
                    self?.mostViewedSubject.onNext(articles)
                }
            }
        }
    }

    func getFavouriteNews() {
        do {
           let articles = try storedNewsService.getFavouriteNews()
            favouritesSubject.onNext(articles)
        } catch {
            errorSubject.onNext(error)
        }
    }
    
    func addArticleToFavourites(_ article: Article) {
        do {
            try storedNewsService.addArticleToFavourites(article)
            getFavouriteNews()
        } catch {
            errorSubject.onNext(error)
        }
    }
    func deleteArticleFromFavourites(_ article: Article) {
        do {
            try storedNewsService.deleteArticleFromFavourites(article)
            getFavouriteNews()
        } catch {
            errorSubject.onNext(error)
        }
    }

    
    func isFavourite(article: Article) -> Bool {
        var isFavourite: Bool = false
        let favouritesArticles = try? favouritesSubject.value()
        if let favouritesArticles {
            let set = Set(favouritesArticles)
            isFavourite = set.contains(article)
        }
        return isFavourite
    }
}
