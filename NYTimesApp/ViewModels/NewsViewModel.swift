//
//  NewsViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import Foundation
import RxSwift
import CoreData

final class NewsViewModel {
    private let newsServise: NewsAPIServiceProtocol
    private let managedObjectContext: NSManagedObjectContext
    static let shared = NewsViewModel()

    var mostEmailed = PublishSubject<[Article]>()
    var mostShared = PublishSubject<[Article]>()
    var mostViewed = PublishSubject<[Article]>()
    var favourites = PublishSubject<[Article]>()

    private init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        newsServise = NewsAPIService()
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }

    func addArticleToFavourites (_ article: Article) {
        let entity = ArticleEntity(context: managedObjectContext)
        entity.title = article.title
        entity.descr = article.description
        entity.url = article.url
        entity.image = article.imageUrl
        
        do {
            try managedObjectContext.save()
        } catch {
            fatalError("Error in saving data")
        }
    }
    func getFavouriteNews() {
        let request = ArticleEntity.fetchRequest()
        do {
            let entities = try managedObjectContext.fetch(request)
            let articles = entities.map{Article(entity: $0)}
            favourites.onNext(articles)
        } catch {
            favourites.onError(error)
        }
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
