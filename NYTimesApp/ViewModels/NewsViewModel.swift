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
    private let managedObjectContext: NSManagedObjectContext
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
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        newsServise = NewsAPIService()
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }

    func addArticleToFavourites(_ article: Article) {
        let entity = ArticleEntity(context: managedObjectContext)
        entity.title = article.title
        entity.descr = article.description
        entity.url = article.url
        entity.image = article.imageUrl
        do {
            try managedObjectContext.save()
            getFavouriteNews()
        } catch {
            errorSubject.onNext(error)
        }
    }

    func deleteArticleFromFavourites(_ article: Article) {
        let request = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url = %@", article.url as CVarArg)
        do {
            let result = try managedObjectContext.fetch(request)
            managedObjectContext.delete(result.first!)
            try managedObjectContext.save()
            getFavouriteNews()
        } catch {
            errorSubject.onNext(error)
        }
    }

    func getFavouriteNews() {
        let request = ArticleEntity.fetchRequest()
        do {
            let entities = try managedObjectContext.fetch(request)
            let articles = entities.map { Article(entity: $0) }
            favouritesSubject.onNext(articles)
        } catch {
            errorSubject.onNext(error)
        }
    }

    func getNewsByCategory(_ category: NewsCathegory) {
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
