//
//  ViewController.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/12/22.
//
import UIKit
import SnapKit

protocol CatDelegate: AnyObject {
    func didToggleLike(liked: Bool)
}

class CatViewController: UIViewController {
    weak var coordinator: Coordinator?
    let repositoriesProvider = GithubRepositoriesProvider()
    let catImageView = UIImageView()
    let heartImage = UIImageView()
    var toggle = false
    weak var delegate: (CatDelegate)?
    
    init(toggle: Bool) {
        super.init(nibName: nil, bundle: nil)
        self.toggle = toggle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(catImageView)
        view.addSubview(heartImage)
        setupHearthImage()
        setupCatImage()
        repositoriesProvider.getImage(urlString: "https://avatars.githubusercontent.com/u/1019875?v=4") { (result: Result<Data, RequestError>) in
            switch result {
            case .success(let success):
                let image = UIImage(data: success)
                self.catImageView.image = image
            case .failure(let failure):
                return
            }
        }
        setConstraints()
    }
    
    private func setConstraints(){
        catImageView.snp.makeConstraints{make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(12)
        }
        heartImage.snp.makeConstraints{make in
            make.top.equalTo(catImageView.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(12)
            make.height.equalTo(60)
        }
    }
    
    private func setupCatImage(){
        catImageView.layer.borderWidth = 3
        catImageView.layer.borderColor = UIColor.black.cgColor
        catImageView.clipsToBounds = true
        catImageView.layer.cornerRadius = 8
        catImageView.contentMode = .scaleAspectFill
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        doubleTap.numberOfTapsRequired = 2
        catImageView.addGestureRecognizer(doubleTap)
        catImageView.isUserInteractionEnabled = true
    }
    
    private func setupHearthImage(){
        if (!toggle) {
            let image = UIImage(systemName: "heart")
            heartImage.image = image
        } else {
            let image = UIImage(systemName: "heart.fill")
            heartImage.image = image
        }
        
        heartImage.tintColor = .red
        heartImage.contentMode = .scaleAspectFit
        heartImage.isUserInteractionEnabled = true
        
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(self.imageTapped))
        heartImage.addGestureRecognizer(tapGR)
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        toggle = !toggle
        self.delegate?.didToggleLike(liked: toggle)
        if sender.state == .ended {
            if (toggle) {
                heartImage.image = UIImage(systemName: "heart.fill")
            } else {
                heartImage.image = UIImage(systemName: "heart")
            }
        }
    }
    
}

