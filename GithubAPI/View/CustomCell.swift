//
//  CustomCell.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/6/22.
//

import Foundation
import UIKit
import SnapKit
import Kingfisher

extension CustomCell {
    struct ViewModel {
        let title: String
        let description: String
        let imageURL: URL?
        
        init(repository: Repository) {
            self.title = repository.name
            self.description = repository.description ?? ""
            self.imageURL = URL(string: repository.owner.avatarUrl ?? "")
        }
    }
}

class CustomCell: UITableViewCell {
    
    let container = UIView()
    let icon = UIImageView()
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    //Fetch the image using the provided url with Kingfisher
    var viewModel: ViewModel? {
        didSet {
            if let image = viewModel?.imageURL {
                icon.kf.setImage(with: image)
            } else  {
                icon.image = UIImage(systemName: "photo")
            }
            titleLabel.text = viewModel?.title
            descriptionLabel.text = viewModel?.description
        }
    }
    static let cellIdentifier = "CustomCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        selectionStyle = .none
        contentView.addSubview(container)
        container.backgroundColor = .lightGray
        container.backgroundColor = container.backgroundColor?.withAlphaComponent(0.6)
        container.addSubview(icon)
        container.addSubview(titleLabel)
        container.addSubview(descriptionLabel)
        container.layer.cornerRadius = 8
        container.clipsToBounds = true
        styleIcon()
        styleTitle()
        styleDescription()
        setupConstraints()
    }
    
    private func styleTitle(){
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = .black
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func styleDescription(){
        descriptionLabel.font = UIFont.systemFont(ofSize: 16)
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = 1
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func styleIcon() {
        icon.contentMode = .scaleAspectFit
        icon.layer.cornerRadius = 30
        icon.clipsToBounds = true
        icon.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        container.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(12)
            make.leading.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
        }
        icon.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(8)
            make.leading.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(8)
            make.width.height.equalTo(60)
        }
        titleLabel.snp.makeConstraints{make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalTo(icon.snp.trailing).offset(16)
        }
        descriptionLabel.snp.makeConstraints{make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(icon.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(8)
        }
    }
    
}


