//
//  UIViewController+Extension.swift
//  NYTimesApp
//
//  Created by Alexandr Mefisto on 16.11.2022.
//

import UIKit
extension UIViewController {
    func showErrorAlert(with error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "Default action"), style: .destructive))
        present(alert, animated: true)
    }
    
    func presetnArticle(_ article: Article) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ArticleViewController.self)) as! ArticleViewController
        controller.setArticle(article)
        let navigationControler = UINavigationController(rootViewController: controller)
        navigationControler.modalPresentationStyle = .fullScreen
        present(navigationControler, animated: true)
    }
}
