//
//  MostSharedViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 21.11.2022.
//

import Foundation

class MostSharedViewModel: NewsViewModel {
    override private init(category: NewsCategory?) {
        super.init(category: .shared)
    }

    init() {
        super.init(category: .shared)
    }
}
