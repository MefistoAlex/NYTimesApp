//
//  Constants.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import Foundation
struct Constants {
    static let header = ["Accept": "application/json"]
    static let parameters = ["api-key": "msExutYA11mjjy1Af7i78edFEn69ZXvi"]
}
enum NewsCathegory: String {
    case emailed = "https://api.nytimes.com/svc/mostpopular/v2/emailed/30.json"
    case shared = "https://api.nytimes.com/svc/mostpopular/v2/shared/30.json"
    case viewed = "https://api.nytimes.com/svc/mostpopular/v2/viewed/30.json"
}
