//
//  ArticlesRequestResult.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import Foundation

struct ArticlesRequestResult: Decodable {
    let status: String
    let num_results: Int
    let results: [IncomingArticle]
   
    struct IncomingArticle: Decodable {
        let url: String
        let title: String
        let abstract: String
        let media: [Media]
    }

    struct Media: Decodable {
        let metadata: [MediaMetaData]

        enum CodingKeys: String, CodingKey {
            case metadata = "media-metadata"
        }
    }

    struct MediaMetaData: Decodable {
        let url: String
    }
}
