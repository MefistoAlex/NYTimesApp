//
//  ViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 20.11.2022.
//

import CoreData
import Foundation
import RxSwift

//MARK: - Bacic class
class NewsViewModel {
    fileprivate var category: NewsCategory?
    fileprivate let newsServise: NewsAPIServiceProtocol
    fileprivate let storedNewsService: StoredNewsServiceProtocol
    
    var newsError: Observable<Error> { errorSubject }
    fileprivate let errorSubject = PublishSubject<Error>()
    
    var news: Observable<[Article]> { newsSubject }
    fileprivate let newsSubject = BehaviorSubject(value: [Article]())

    init() {
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

//MARK: -  MostEmailedViewModel

class MostEmailedViewModel: NewsViewModel {
    override init() {
        super.init()
        category = .emailed
    }
}

//MARK: - MostSharedViewModel
class MostSharedViewModel: NewsViewModel {
    override init() {
        super.init()
        category = .shared
    }
}

//MARK: - MostViewedViewModel

class MostViewedViewModel: NewsViewModel {
    override init() {
        super.init()
        category = .viewed
    }
}

//MARK: -  FavouritesNewsViewModel

class FavouritesNewsViewModel: NewsViewModel {
    static let  shared = FavouritesNewsViewModel()
    
    override private init() {
    }
    
   override func getNews(){
        do {
           let articles = try storedNewsService.getFavouriteNews()
            newsSubject.onNext(articles)
        } catch {
            errorSubject.onError(error)
        }
    }
    
    
}
