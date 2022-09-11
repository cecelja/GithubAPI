//
//  RepositoryModel.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/11/22.
//

import Foundation

//This is our model that is independent of any UIKit class
struct Repository: Codable {
    let name: String
    let owner: Owner
    let description: String?
    let forks: Int?
    let stars: Int?
    let language: String?

    enum CodingKeys: String, CodingKey {
        case name, owner, description, language
        case forks = "forks_count"
        case stars = "stargazers_count"
    }
}


struct Owner: Codable {
    let login: String
    let avatarUrl: String?

    enum CodingKeys: String, CodingKey {
        case login, avatarUrl = "avatar_url"
    }
}
