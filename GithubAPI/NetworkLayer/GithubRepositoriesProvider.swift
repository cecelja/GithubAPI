//
//  GithubRepositoriesProvider.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/11/22.
//

import Foundation

class GithubRepositoriesProvider {
    //Create an instance of the class that can be used by everyone
    public static let shared = GithubRepositoriesProvider()
    
    func getRepositories(organisation org: String,
                         completionHandler: @escaping (Result<[Repository], RequestError>) -> Void) {
        guard let url = URL(string: "https://api.github.com/orgs/\(org)/repos") else {
            completionHandler(.failure(.clientError))
            return
        }
        
        var request = URLRequest(url: url)
            request.httpMethod = "GET"
            NetworkService.shared.executeUrlRequest(request, completionHandler: completionHandler)
    }
    
    func getImage(urlString: String, completionHandler: @escaping ((Result<Data, RequestError>) -> Void)) {
        guard let url = URL(string: urlString) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        NetworkService.shared.executeUrlRequest(request, completionHandler: completionHandler)
    }
}
