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

class Coordinator: CoordinatorProtocol {
    var navigationController: UINavigationController
    var catController = CatViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
    
    func openCatController(repositoryProvider: GithubRepositoriesProvider) {
        catController = CatViewController()
        catController.coordinator = self
        self.navigationController.pushViewController(catController, animated: true)
    }
    
}

