//
//  NetworkManager.swift
//  RandomContactList
//
//  Created by Jorgen Shiller on 15.11.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    private let urlParameters = [
        "results": "\(15)"
    ]
    
    func fetchPerson(from url: String, completion: @escaping(Result<[User], AFError>) -> Void) {
        AF.request(url, parameters: urlParameters)
            .validate()
            .responseJSON() { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let users = User.getUser(from: value)
                    completion(.success(users))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
        AF.request(url)
            .validate()
            .responseData { dataResponse in
                switch dataResponse.result {
                case .success(let imgData):
                    completion(.success(imgData))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
