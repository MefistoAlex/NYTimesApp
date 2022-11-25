//
//  StoredNewsService.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 20.11.2022.
//

import CoreData
import Foundation
import UIKit

protocol StoredNewsServiceProtocol {
    func getFavouriteNews() throws -> [Article]
    func addArticleToFavourites(_ article: Article) throws
    func deleteArticleFromFavourites(_ article: Article) throws
}

class StoredNewsService: StoredNewsServiceProtocol {
    private let managedObjectContext: NSManagedObjectContext

    init() {
        managedObjectContext = CoreDataStack().persistentContainer.viewContext
    }

    func getFavouriteNews() throws -> [Article] {
        let request = ArticleEntity.fetchRequest()
        do {
            let entities = try managedObjectContext.fetch(request)
            let articles = entities.map { Article(entity: $0) }
            return articles
        } catch {
            throw error
        }
    }

    func addArticleToFavourites(_ article: Article) throws {
        let entity = ArticleEntity(context: managedObjectContext)
        entity.title = article.title
        entity.descr = article.description
        entity.url = article.url
        entity.image = article.imageUrl
        do {
            try managedObjectContext.save()
        } catch {
            throw error
        }
    }

    func deleteArticleFromFavourites(_ article: Article) throws {
        let request = ArticleEntity.fetchRequest()
        request.predicate = NSPredicate(format: "url = %@", article.url as CVarArg)
        do {
            let result = try managedObjectContext.fetch(request)
            managedObjectContext.delete(result.first!)
            try managedObjectContext.save()
        } catch {
            throw error
        }
    }
}
