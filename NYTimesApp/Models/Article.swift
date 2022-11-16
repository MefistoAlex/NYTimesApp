//
//  Article.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import Foundation
struct Article {
    let title: String
    let description: String
    let url: String
    let imageUrl: String?

    init(incomingArticle: ArticlesRequestResult.IncomingArticle) {
        title = incomingArticle.title
        description = incomingArticle.abstract
        url = incomingArticle.url
        //getting image with hight quality
        imageUrl = incomingArticle.media.last?.metadata.last?.url
    }
}
