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
    
    func setupTableView() {
        addSubview(tableView)
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.cellIdentifier)
        tableView.separatorStyle = .singleLine
        
        tableView.snp.makeConstraints{make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-12)
        }
        
    }
}
