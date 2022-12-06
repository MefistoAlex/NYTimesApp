//
//  NYTimesAppTests.swift
//  NYTimesAppTests
//
//  Created by Alexandr Mefisto on 05.12.2022.
//

@testable import NYTimesApp
import XCTest

final class NYTimesAppTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK: - Article testing

    func testArticleInitFromEntity() {
        // arrange
        let coreData = CoreDataStack()
        let moc = coreData.persistentContainer.viewContext
        let entity = ArticleEntity(context: moc)
        entity.url = "url"
        entity.title = "title"
        entity.descr = "abstract"
        entity.image = "image"
        
        // act
        let article = Article(entity: entity)
        
        // assert
        XCTAssertEqual(entity.url, article.url)
        XCTAssertEqual(entity.title, article.title)
        XCTAssertEqual(entity.descr, article.description)
        XCTAssertEqual(entity.image, article.imageUrl)
    }
    
    //MARK: - CoreDataStack
    func testCoreDataStackSaveContext () {
        // arrange
        let coreData = CoreDataStack()
        let moc = coreData.persistentContainer.viewContext
        let entity = ArticleEntity(context: moc)
        entity.url = "url"
        entity.title = "title"
        entity.descr = "abstract"
        entity.image = "image"
        
        // act
        coreData.saveContext()
        
        // assert
        let fetchedEntity = moc.object(with: entity.objectID)
        XCTAssertEqual(entity, fetchedEntity, "Enteties must bee equal")
         
        // clear
        moc.delete(entity)
        coreData.saveContext()
        
    }
    func testArticleInitFromIncomingArticle() {
        // arrange
        let mediaMetaData = ArticlesRequestResult.MediaMetaData(url: "image")
        let media = ArticlesRequestResult.Media(metadata: [mediaMetaData])
        let incomingArticle = ArticlesRequestResult.IncomingArticle(
            url: "url",
            title: "title",
            abstract: "abstract",
            media: [media]
        )
        
        // act
        let article = Article(incomingArticle: incomingArticle)
        
        // assert
        XCTAssertEqual(incomingArticle.url, article.url)
        XCTAssertEqual(incomingArticle.title, article.title)
        XCTAssertEqual(incomingArticle.abstract, article.description)
        XCTAssertEqual("image", article.imageUrl)
    }


    func testArticleViewControllerSettingArticle() {
        // arrange
        let articleViewController = ArticleViewController()
        let incomingArticle = ArticlesRequestResult.IncomingArticle(
            url: "url",
            title: "title",
            abstract: "abstract",
            media: []
        )
        let article = Article(incomingArticle: incomingArticle)

        // act
        articleViewController.setArticle(article)

        // assert
        XCTAssertEqual(article, articleViewController.article)
    }
}
