//
//  MostViewedViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 21.11.2022.
//

import Foundation

class MostViewedViewModel: NewsViewModel {
    override private init(category: NewsCategory?) {
        super.init(category: .viewed)
    }

    init() {
        super.init(category: .viewed)
    }
}
