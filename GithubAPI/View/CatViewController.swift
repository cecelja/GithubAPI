//
//  ViewController.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/12/22.
//
import UIKit
import SnapKit

class CatViewController: UIViewController {
    weak var coordinator: Coordinator?
    let repositoriesProvider: GithubRepositoriesProvider
    let label = UILabel()
    let catImageView = UIImageView()
    
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
        view.addSubview(catImageView)
        catImageView.layer.borderWidth = 3
        catImageView.layer.borderColor = UIColor.black.cgColor
        catImageView.clipsToBounds = true
        catImageView.layer.cornerRadius = 8
        catImageView.contentMode = .scaleAspectFill
        repositoriesProvider.getImage(urlString: "https://avatars.githubusercontent.com/u/1019875?v=4") { (result: Result<Data, RequestError>) in
            switch result {
            case .success(let success):
                let image = UIImage(data: success)
                self.catImageView.image = image
            case .failure(let failure):
                return
            }
        }
        
        catImageView.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }
    
}
