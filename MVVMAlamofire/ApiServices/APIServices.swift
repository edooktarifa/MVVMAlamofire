//
//  APIServices.swift
//  MVVMAlamofire
//
//  Created by Edo Oktarifa on 22/06/21.
//

import Foundation
import Alamofire

class APIServices {
    static let instance = APIServices()
    func request<T: Decodable, E: Decodable>(url: String, method: HTTPMethod, params: Parameters?, encoding: ParameterEncoding, headers: HTTPHeaders?, completion: @escaping (T?, E?, Error?)->()) {
        
        Alamofire.request(url, method: method, parameters: params, encoding: encoding, headers: headers).validate(statusCode: 200...300).responseJSON {
            response in
            
            switch response.result {
            case .success(_):
                guard let data = response.data else { return }
                
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    completion(jsonData, nil, nil)
                } catch let jsonError {
                    print(jsonError)
                }
            case .failure(let error):
                guard let data = response.data else { return }
                guard let statusCode = response.response?.statusCode else { return }
                
                switch statusCode {
                case 400..<500:
                    do {
                        let jsonError = try JSONDecoder().decode(E.self, from: data)
                        completion(nil, jsonError, nil)
                    } catch let jsonError {
                        print(jsonError)
                    }
                default:
                    completion(nil, nil, error)
                }
            }
        }
    }
}
