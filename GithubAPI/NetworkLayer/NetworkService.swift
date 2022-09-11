//
//  NetworkService.swift
//  GithubAPI
//
//  Created by Filip Cecelja on 9/11/22.
//

import Foundation
//With this enum we are classifying what errors might appear and how to respond
enum RequestError: Int, Error {
    case clientError = 400
    case serverError = 500
    case noDataError = 404
    // data decoding breaks
    case decodingError = 405
}

//With this enum we are returning the data we recieved
//It is needed four our CompletionHandler
enum Result<Success, Failure> where Failure: Error {
    //A success, storing a `Success` value.
    case success(Success)
    //A failure, storing a `Failure` value.
    case failure(Failure)
}

class NetworkService {
    //Create a base instance of the class that will be used by all requests
    public static let shared = NetworkService()
    
    public func executeUrlRequest<T: Decodable>(_ request: URLRequest,
                            completionHandler: @escaping (Result<T, RequestError>) -> Void) {
        //First we need to configure our URLSession object
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForResource = 5
        
        let dataTask = URLSession(configuration: config).dataTask(with: request) { data, response, error in
            //If the error is nil continue with the task
            guard error == nil else {
                completionHandler(.failure(.clientError))
                return
            }
            //If the response is a type of HTTPURLResponse object than continue with the request
            guard let httpResponse = response as? HTTPURLResponse else {
                //If the statement is false log that the response failed
                DispatchQueue.main.async {
                    completionHandler(.failure(.serverError))
                }
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async {
                    if (400...499).contains(httpResponse.statusCode) {
                            completionHandler(.failure(.clientError))
                        } else if (500...599).contains(httpResponse.statusCode) {
                            completionHandler(.failure(.serverError))
                        }
                    }
                    return
                }
            //Unwrap the optional that contains data to see if it is not nil
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(.noDataError))
                }
                return
            }
            
            if let data = data as? T {
                DispatchQueue.main.async {
                    completionHandler(.success(data))
                }
                return
            }
            //Decoding the json data into our swift Model data
            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                print("Problem with decoding data")
                DispatchQueue.main.async {
                    completionHandler(.failure(.decodingError))
                }
                return
            }
            //Tell the main thread that we successfully decoded the data
            DispatchQueue.main.async {
                completionHandler(.success(value))
            }
        }
        DispatchQueue.global(qos: .userInitiated).async {
            dataTask.resume()
        }
        
    }
}




























