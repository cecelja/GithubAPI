//
//  GithubRepositoriesController.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/9/22.
//

import Foundation
import UIKit
import SnapKit

extension GithubRepositoriesController {
    struct ViewModel {
        let githubRepositories: [Repository]
    }
}

class GithubRepositoriesController: UIViewController {
    let repositoriesProvider: GithubRepositoriesProvider
    weak var coordinator: Coordinator?
    
    var repositoriesView: RepositoriesView? {
        guard let view = view as? RepositoriesView else {
            fatalError()
        }
        return view
    }

    
    var viewModel: ViewModel? {
        didSet {
            repositoriesView?.tableView.reloadData()
        }
    }
    
    init(repositoriesProvider: GithubRepositoriesProvider) {
        self.repositoriesProvider = repositoriesProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = RepositoriesView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var reactive =  ReactiveClass()
        reactive.reactiveFunc()
        
        view.backgroundColor = .white
        self.title = "GithubAPI"
        repositoriesView?.setupTableView()
        repositoriesView?.tableView.dataSource = self
        repositoriesView?.tableView.delegate = self
        repositoriesView?.catButton.addTarget(self, action: #selector(goToCatController), for: .touchUpInside)
        repositoriesProvider.getRepositories(organisation: "apple") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let repositories):
                    self?.viewModel = ViewModel(githubRepositories: repositories)
                case .failure(let error):
                    self?.viewModel = ViewModel(githubRepositories: [])
                    self?.presentAlertLabel(title: "Network error", description: error.localizedDescription)
                }
            }
        }
    }
    
    func presentAlertLabel(title: String, description: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func goToCatController() {
        coordinator?.openCatController(repositoryProvider: repositoriesProvider)
    }

}

extension GithubRepositoriesController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.githubRepositories != nil ? 1 : 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.githubRepositories.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellIdentifier, for: indexPath) as? CustomCell,
              let viewModel = viewModel, indexPath.row < viewModel.githubRepositories.count else {
            return UITableViewCell()
        }
        
        cell.viewModel = CustomCell.ViewModel(repository: viewModel.githubRepositories[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

extension GithubRepositoriesController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.openDetailsController(index: indexPath.row, viewModel: self.viewModel)
    }
    
}


