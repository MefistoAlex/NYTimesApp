//
//  MostEmailedViewController.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import UIKit

class MostEmailedViewController: UIViewController {

    var newsService: NewsAPIServiceProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        newsService = NewsAPIService()
        newsService?.getNewsByCategory(.viewed, completion: { articles, error in
            if let articles {
                print(articles)
            }
            if let error {
                print(error)
            }
        })
        
        // Do any additional setup after loading the view.
    }


}

