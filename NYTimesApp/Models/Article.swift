//
//  Article.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import Foundation

struct Article: Hashable {
    let title: String
    let description: String
    let url: String
    let imageUrl: String?

    init(incomingArticle: ArticlesRequestResult.IncomingArticle) {
        title = incomingArticle.title
        description = incomingArticle.abstract
        url = incomingArticle.url
        // getting image with hight quality
        imageUrl = incomingArticle.media.last?.metadata.last?.url
    }

    init(entity: ArticleEntity) {
        title = entity.title!
        description = entity.descr!
        url = entity.url!
        // getting image with hight quality
        imageUrl = entity.image
    }
    
    init(title: String, description: String, url: String, imageUrl: String?){
        self.title =  title
        self.description = description
        self.url = url
        self.imageUrl = imageUrl

    }
}
