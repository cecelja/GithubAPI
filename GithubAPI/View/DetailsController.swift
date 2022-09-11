//
//  ViewController.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/6/22.
//

import UIKit
import SnapKit

extension DetailsController {
    struct DetailsViewModel {
        let title: String
        let login: String
        var description: String?
        let forks: Int?
        let stars: Int?
        let imageURL: URL?
        
        init(repository: Repository) {
            self.title = repository.name
            self.description = repository.description ?? ""
            self.imageURL = URL(string: repository.owner.avatarUrl ?? "")
            self.login = repository.owner.login
            self.description = repository.description
            self.stars = repository.stars
            self.forks = repository.forks
        }
    }
}

class DetailsController: UIViewController {
    
    private let container: UIView = UIView()
    private let icon: UIImageView = UIImageView()
    private var titleLabel: UILabel = UILabel()
    private var loginLabel: UILabel = UILabel()
    private var descriptionLabel: UILabel = UILabel()
    private var forksLabel: UILabel = UILabel()
    private var starsLabel: UILabel = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    init(repo: Repository) {
//        detailsViewModel = DetailsViewModel(repository: repo)
//        print(detailsViewModel)
//        print("initializing details")
//        super.init(nibName: nil, bundle: nil)
//    }
    
    init(){
        super.init(nibName: nil, bundle: nil)
    }
    
    //Fetch the image using the provided url with Kingfisher
    var detailsViewModel: DetailsViewModel? {
        didSet {
            if let image = detailsViewModel?.imageURL {
                icon.kf.setImage(with: image)
            } else  {
                icon.image = UIImage(systemName: "photo")
            }
            print("setting labels")
            let forksText = "Number of forks: \((detailsViewModel?.forks)!)"
            let starsText = "Number of stars: \((detailsViewModel?.stars)!)"
            let loginText = "By: \((detailsViewModel?.login)!)"
            
            titleLabel = UILabel.with(text: detailsViewModel?.title ?? "", color: .black, size: 18, fontStyle: "bold")
            descriptionLabel = UILabel.with(text: detailsViewModel?.description ?? "Description is not available for this project.", color: .black, size: 18, fontStyle: "default")
            loginLabel = UILabel.with(text: loginText, color: .gray, size: 16, fontStyle: "default")
            forksLabel = UILabel.with(text: forksText, color: .black, size: 18, fontStyle: "default")
            starsLabel = UILabel.with(text: starsText, color: .black, size: 18, fontStyle: "default")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        styleIcon()
        styleLabels()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(container)
        container.addSubview(icon)
        container.addSubview(titleLabel)
        container.addSubview(loginLabel)
        
        view.addSubview(descriptionLabel)
        view.addSubview(forksLabel)
        view.addSubview(starsLabel)
    }
    
    private func styleLabels() {
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        forksLabel.translatesAutoresizingMaskIntoConstraints = false
        starsLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }

    private func styleIcon() {
        icon.contentMode = .scaleAspectFill
        icon.layer.cornerRadius = 30
        icon.clipsToBounds = true
        icon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        container.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(200)
        }
        icon.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(12)
            make.width.height.equalTo(100)
        }
        titleLabel.snp.makeConstraints{make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(icon.snp.trailing).offset(16)
        }
        loginLabel.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(icon.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(8)
        }
        descriptionLabel.snp.makeConstraints{make in
            make.top.equalTo(container.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        forksLabel.snp.makeConstraints{make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        starsLabel.snp.makeConstraints{make in
            make.top.equalTo(forksLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }

}

