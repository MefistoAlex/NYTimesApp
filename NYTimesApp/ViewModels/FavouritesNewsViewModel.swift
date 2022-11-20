//
//  FavouritesNewsViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 21.11.2022.
//

import Foundation

class FavouritesNewsViewModel: NewsViewModel {
    static let shared = FavouritesNewsViewModel()
    override private init(category: NewsCategory?) {
        super.init(category: nil)
    }

    init() {
        super.init(category: nil)
    }
}
