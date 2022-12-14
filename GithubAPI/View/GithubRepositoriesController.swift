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
    let tableView = UITableView()
    let repositoriesProvider: GithubRepositoriesProvider

    
    var viewModel: ViewModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    init(repositoriesProvider: GithubRepositoriesProvider) {
        self.repositoriesProvider = repositoriesProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "GithubAPI"
        setupTableView()
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
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.cellIdentifier)
        tableView.separatorStyle = .singleLine
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-12)
        }
        
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
        var detailsController = DetailsController()
        detailsController.detailsViewModel = DetailsController.DetailsViewModel(repository: (viewModel?.githubRepositories[indexPath.row])!)
        detailsController.modalPresentationStyle = .pageSheet
        detailsController.sheetPresentationController?.detents = [.medium()]
        present(detailsController, animated: true)
        
    }
}
