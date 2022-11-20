//
//  MostEmailedViewModel.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 21.11.2022.
//

import Foundation

class MostEmailedViewModel: NewsViewModel {
    override private init(category: NewsCategory?) {
        super.init(category: .emailed)
    }

    init() {
        super.init(category: .emailed)
    }
}
