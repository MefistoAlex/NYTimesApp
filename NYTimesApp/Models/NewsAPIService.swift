//
//  NewsAPIService.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import Foundation
enum NewsCathegory {
    case emailed
    case shared
    case viewed
}
protocol NewsAPIServiceProtocol {
    func getNewsByCategory (_ category: NewsCathegory, completion: @escaping (_ coins: [Coin]?, _ error: Error?) -> Void)
}

class NewsAPIService: NewsAPIServiceProtocol {
    private let apiManager: APIManager

    init() {
        apiManager = AlamofireAPIManager()
    }
    func getNewsByCategory(_ category: NewsCathegory) {
        <#code#>
    }
    
    
}
