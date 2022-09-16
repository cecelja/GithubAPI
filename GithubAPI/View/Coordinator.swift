//
//  Coordinator.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/11/22.
//
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController {get set}
    func start()
}

class Coordinator: CoordinatorProtocol, CatDelegate {
    var toggleCat = false

    var navigationController: UINavigationController
    var catController: CatViewController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.catController = CatViewController(toggle: toggleCat)
    }
    
    func start() {
        let vc = GithubRepositoriesController(repositoriesProvider: GithubRepositoriesProvider())
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openDetailsController(index: Int, viewModel: GithubRepositoriesController.ViewModel?) {
        let detailsController = DetailsController()
        detailsController.coordinator = self
        detailsController.detailsViewModel = DetailsController.DetailsViewModel(repository: (viewModel?.githubRepositories[index])!)
        detailsController.modalPresentationStyle = .pageSheet
        detailsController.sheetPresentationController?.detents = [.medium()]
        self.navigationController.present(detailsController, animated: true)
    }
    
    func openCatController() {
        catController.coordinator = self
        catController.delegate = self
        self.navigationController.pushViewController(catController, animated: true)
    }
    
    func didToggleLike(liked: Bool) {
        if (liked) {
            let btn = (navigationController.viewControllers.first as? GithubRepositoriesController)?
                .repositoriesView?.catButton
            btn?.backgroundColor = .red
            print("We have delegate liftoff!")
        } else {
            (navigationController.viewControllers.first as? GithubRepositoriesController)?
                .repositoriesView?.catButton.backgroundColor =  .systemGray.withAlphaComponent(0.6)
            print("Houston we have a delegate problem!")
        }
    }
    
    
}

