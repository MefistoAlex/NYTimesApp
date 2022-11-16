//
//  ArticlesRequestResult.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import Foundation

struct ArticlesRequestResult: Encodable {
    let status: String
    let num_results: Int
    let results: [Article]
   
    struct Article: Encodable {
        let url: String
        let title: String
        let abstract: String
        let media: [Media]
    }

    struct Media: Encodable {
        let metadata: [MediaMetaData]

        enum CodingKeys: String, CodingKey {
            case metadata = "media-metadata"
        }
    }

    struct MediaMetaData: Encodable {
        let url: String
    }
}
