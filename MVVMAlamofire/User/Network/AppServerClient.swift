//
//  UserApi.swift
//  MVVMAlamofire
//
//  Created by Edo Oktarifa on 09/06/21.
//

import Foundation
import Alamofire

enum NetworkError: Int, Error {
    case unAuthorized = 401
    case notFound = 404
}

class AppServerClient {
    func getUser(completion: @escaping (Result<[User], NetworkError>) -> Void){
        Alamofire.request("https://jsonplaceholder.typicode.com/users", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        completion(.failure(nil))
                        return }
                    
                    let user = try JSONDecoder().decode([User].self, from: data)
                    completion(.success(payload: user))
                } catch {
                    completion(.failure(nil))
                }
            case .failure:
                if let statusCode = response.response?.statusCode {
                    let reason = NetworkError(rawValue: statusCode)
                    completion(.failure(reason))
                }
                completion(.failure(nil))
            }
        }
    }
    
    func getPhoto(completion: @escaping (Result<User, NetworkError>) -> Void){
        Alamofire.request("https://jsonplaceholder.typicode.com/users/1", method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON {
            
            response in
            
            switch response.result{
            case .success:
                do {
                    guard let data = response.data else {
                        completion(.failure(nil))
                        return }
                    let user = try JSONDecoder().decode(User.self, from: data)
                    completion(.success(payload: user))
                } catch {
                    completion(.failure(nil))
                }
                
            case .failure:
                if let statusCode = response.response?.statusCode {
                    let reason = NetworkError(rawValue: statusCode)
                    completion(.failure(reason))
                }
                completion(.failure(nil))
            }
        }
    }
}

