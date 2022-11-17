//
//  NewsAPIService.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import Foundation

protocol NewsAPIServiceProtocol {
    func getNewsByCategory(_ category: NewsCathegory, completion: @escaping (_ articles: [Article]?, _ error: Error?) -> Void)
}

class NewsAPIService: NewsAPIServiceProtocol {
    private let apiManager: APIManager

    init() {
        apiManager = AlamofireAPIManager()
    }

    func getNewsByCategory(_ category: NewsCathegory, completion: @escaping ([Article]?, Error?) -> Void) {
        apiManager.request(urlString: category.rawValue,
                           method: .get,
                           dataType: ArticlesRequestResult.self,
                           headers: Constants.header,
                           parameters: Constants.parameters) { data, error in
            var articles: [Article]?
            if let data {
                articles = []
                data.results.forEach {
                    articles?.append(Article(incomingArticle: $0))
                }
                completion(articles, nil)
            }

            if let error {
                completion(nil, error)
            }
        }
    }
}
