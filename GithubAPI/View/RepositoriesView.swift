//
//  RepositoriesView.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/12/22.
//

import Foundation
import UIKit
import SnapKit

class RepositoriesView: UIView {
    let tableView = UITableView()
    let catButton = UIButton()
    
    func setupTableView() {
        addSubview(tableView)
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.cellIdentifier)
        tableView.separatorStyle = .singleLine
        addSubview(catButton)
        styleCatButton()
        catButton.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview().inset(12)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(12)
            make.height.equalTo(60)
        }
        
        tableView.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(catButton.snp.bottom).offset(12)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
        }
    }
    

    
    func styleCatButton(){
        catButton.setTitle("Cat Button", for: .normal)
        catButton.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        catButton.setTitleColor(.black, for: .normal)
        catButton.backgroundColor = .lightGray
        catButton.backgroundColor = catButton.backgroundColor?.withAlphaComponent(0.6)
        catButton.layer.cornerRadius = 8
        catButton.clipsToBounds = true
        catButton.translatesAutoresizingMaskIntoConstraints = false
    }
}
