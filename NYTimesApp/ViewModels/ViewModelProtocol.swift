//
//  ViewModelProtocol.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 21.11.2022.
//
import Foundation
import RxSwift

protocol ViewModelProtocol {
    var newsError: Observable<Error> { get }
    var news: Observable<[Article]> { get }
    func getNews()
}
